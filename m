Content-Type: multipart/mixed; boundary="===============2261078087343417995=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests: mptcp: add link failure
 test case
Date: Thu, 08 Oct 2020 16:09:46 -0700
Message-ID: <alpine.OSX.2.23.453.2010081602190.49214@ozore-mobl2.amr.corp.intel.com>
In-Reply-To: 20201001215600.17614-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6261

--===============2261078087343417995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 1 Oct 2020, Florian Westphal wrote:

> Add a test case where a link fails with multiple subflows.
> The expectation is that MPTCP will transmit any data that
> could not be delivered via the failed link on another subflow.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> NB: One could make the 'down link' deterministic:
> this will down one of the 4 links randonly.

The random link selection is good, since it looks like some retransmission =

behavior is currently affected by the order of the subflows.

>
> The test case is new, its a copy of
> "multiple subflows and signal", just with added link-fail.
>
> Alternative would be to just extend the existing one.

New test case is fine by me.

>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 111 +++++++++++++-----
> 1 file changed, 84 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 08f53d86dedc..a8be79b226df 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

...

> @@ -487,10 +533,21 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags s=
ignal
> ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> -run_tests $ns1 $ns2 10.0.1.1
> +run_tests $ns1 $ns2 10.0.1.1 0
> chk_join_nr "multiple subflows and signal" 3 3 3
> chk_add_nr 1 1
>
> +# accept and use add_addr with additional subflows

"...and link loss" (to differentiate from previous test)

> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> +run_tests $ns1 $ns2 10.0.1.1 1
> +chk_join_nr "multiple flows, signal, link failure" 3 3 3
> +chk_add_nr 1 1
> +
> # single subflow, remove
> reset
> ip netns exec $ns1 ./pm_nl_ctl limits 0 1


--
Mat Martineau
Intel
--===============2261078087343417995==--
