# SPDX-FileCopyrightText: © 2023 Uri Shaked <uri@tinytapeout.com>
# SPDX-License-Identifier: MIT

import cocotb


@cocotb.test()
async def test_adder(dut):
  dut._log.info("Start")
  

