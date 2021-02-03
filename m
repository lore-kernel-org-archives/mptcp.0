Content-Type: multipart/mixed; boundary="===============7675552840509918495=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [bug report] the test cases for signaling invalid addresses
 don't work
Date: Wed, 03 Feb 2021 19:30:19 +0800
Message-ID: <CA+WQbwuPyd6cMTZgxfZVtoDR-aaNkgRYNzA_dFe9oyjRxSoqVA@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7607

--===============7675552840509918495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I added two test cases for signaling multi addresses today:

         # signal addresses
         reset
         ip netns exec $ns1 ./pm_nl_ctl limits 3 3
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
         ip netns exec $ns2 ./pm_nl_ctl limits 3 3
         run_tests $ns1 $ns2 10.0.1.1
         chk_join_nr "signal addresses" 3 3 3
         chk_add_nr 3 3

         # signal invalid addresses
         reset
         ip netns exec $ns1 ./pm_nl_ctl limits 3 3
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.13.1 flags signal
         ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
         ip netns exec $ns2 ./pm_nl_ctl limits 3 3
         run_tests $ns1 $ns2 10.0.1.1
         chk_join_nr "signal invalid addresses" 0 0 0
         chk_add_nr 1 1

The 1st one works well, the 2nd one added three invalid addresses, but
only got 1 ADD_ADDR and 1 ECHO. I thought it should be 0 ADD_ADDR or
3 ADD_ADDRs.

In the 2nd test case, mptcp_pm_create_subflow_or_signal_addr was only
triggered once when the msk is established. Since the first address is an
invalid one, the subflow for it cannot be created successfully. So
mptcp_pm_nl_subflow_established could not be invoked. The last two
addresses didn't have a chance to be announced. I think this behavior is
incorrect.

I have several questions about this:

1. Is this an known issue? Is it worth creating a new issue on github and
fixing it?

2. What do we expect for the 2nd test case, 0 ADD_ADDR or 3 ADD_ADDRs?

3. Should we skip announcing the invalid addresses?

4. Or should we change the logic of mptcp_pm_create_subflow_or_signal_addr
to announce all the invalid addresses?

Please give me some suggestions about this.

Thanks.

-Geliang
--===============7675552840509918495==--
