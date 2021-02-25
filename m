Content-Type: multipart/mixed; boundary="===============5956171618358343183=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/5] move to next addr when
 timeout
Date: Thu, 25 Feb 2021 16:01:51 +0100
Message-ID: <01e5e8a4-d03f-1395-cdee-8aa004706233@tessares.net>
In-Reply-To: cover.1614138509.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7955

--===============5956171618358343183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 24/02/2021 04:56, Geliang Tang wrote:
> v3:
>   - invoke lookup_subflow_by_daddr in mptcp_pm_nl_add_addr_received.
>   - add a new patch "drop argument port from mptcp_pm_announce_addr".
> =

> v2:
>   - invoke lookup_subflow_by_daddr in mptcp_pm_add_addr_received, not in
>   mptcp_pm_nl_add_addr_received.
>   - add a sanity check on cfg_do_w.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Thank you for the patches and the reviews!
I just added them in our tree with Mat's RvB tag:

Patches 1/5 and 2/5 have been added before "mptcp: drop unused subflow =

in mptcp_pm_subflow_established":

- d63677a633cf: mptcp: drop argument port from mptcp_pm_announce_addr
- c7ef42ed2451: mptcp: skip connecting the connected address
- a681ac4046d5: conflict in t/mptcp-add-rm_list_tx-in-mptcp_pm_data
- Results: de59595c18b3..52c9bb446e5d

The rest just after the mentioned patch:

- 1d7d152ed66f: mptcp: move to next addr when timeout
- 9f635adaa8c3: selftests: mptcp: add cfg_do_w for cfg_remove
- da596d8d5312: selftests: mptcp: timeout testcases for multi addresses
- Results: 52c9bb446e5d..8a82f6b7cf01

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5956171618358343183==--
