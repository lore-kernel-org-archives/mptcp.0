Content-Type: multipart/mixed; boundary="===============4124109724320140215=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/5] move to next addr when
 timeout
Date: Fri, 26 Feb 2021 11:42:06 +0800
Message-ID: <CA+WQbwsMGQaDeAGc6DQBQvQecDHBQ8Dr6xaSsG1kfrfniOxpig@mail.gmail.com>
In-Reply-To: 01e5e8a4-d03f-1395-cdee-8aa004706233@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7959

--===============4124109724320140215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B42=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Mat,
>
> On 24/02/2021 04:56, Geliang Tang wrote:
> > v3:
> >   - invoke lookup_subflow_by_daddr in mptcp_pm_nl_add_addr_received.
> >   - add a new patch "drop argument port from mptcp_pm_announce_addr".
> >
> > v2:
> >   - invoke lookup_subflow_by_daddr in mptcp_pm_add_addr_received, not in
> >   mptcp_pm_nl_add_addr_received.
> >   - add a sanity check on cfg_do_w.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151
>
> Thank you for the patches and the reviews!
> I just added them in our tree with Mat's RvB tag:
>
> Patches 1/5 and 2/5 have been added before "mptcp: drop unused subflow
> in mptcp_pm_subflow_established":
>
> - d63677a633cf: mptcp: drop argument port from mptcp_pm_announce_addr
> - c7ef42ed2451: mptcp: skip connecting the connected address
> - a681ac4046d5: conflict in t/mptcp-add-rm_list_tx-in-mptcp_pm_data
> - Results: de59595c18b3..52c9bb446e5d
>
> The rest just after the mentioned patch:
>
> - 1d7d152ed66f: mptcp: move to next addr when timeout
> - 9f635adaa8c3: selftests: mptcp: add cfg_do_w for cfg_remove
> - da596d8d5312: selftests: mptcp: timeout testcases for multi addresses
> - Results: 52c9bb446e5d..8a82f6b7cf01
>
> Tests + export have been queued!

I'm sorry to bring you extra work and trouble. But my patches on the
export/20210225T204843 branch still need to be adjusted the order.

This series "move to next addr when timeout" should be put after the
series "move to next addr and testcases" like this:

  mptcp: free resources when the port number is mismatched
  mptcp: add rm_list in mptcp_out_options
  mptcp: add rm_list_tx in mptcp_pm_data
  mptcp: add rm_list in mptcp_options_received
  mptcp: add rm_list_rx in mptcp_pm_data
  mptcp: remove multi addresses in PM
  mptcp: remove multi subflows in PM
  mptcp: remove multi addresses and subflows in PM
  mptcp: remove a list of addrs when flushing
  selftests: mptcp: add invert argument for chk_rm_nr
  selftests: mptcp: set addr id for removing testcases
  selftests: mptcp: add testcases for removing addrs
  mptcp: export lookup_anno_list_by_saddr
  mptcp: move to next addr when subflow creation fail
  selftests: mptcp: signal addresses testcases
  mptcp: drop argument port from mptcp_pm_announce_addr
  mptcp: skip connecting the connected address
  mptcp: drop unused subflow in mptcp_pm_subflow_established
  mptcp: move to next addr when timeout
  selftests: mptcp: add cfg_do_w for cfg_remove
  selftests: mptcp: timeout testcases for multi addresses

Could you please help me to re-apply them in this order?

Thanks very much.

-Geliang




>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============4124109724320140215==--
