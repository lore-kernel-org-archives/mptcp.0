Content-Type: multipart/mixed; boundary="===============6182889926667909805=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH] Squash-to: "mptcp: implement
 mptcp_pm_remove_subflow v9"
Date: Tue, 15 Sep 2020 16:27:10 +0800
Message-ID: <CA+WQbwuQSZbXPv9jkjQCNyy9CAfB5YwYxH7FsBySuedw7WZHhg@mail.gmail.com>
In-Reply-To: 050f7802-d391-0278-7216-cd943d6191f6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5872

--===============6182889926667909805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:45=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo,
>
> On 08/09/2020 08:32, Geliang Tang wrote:
> > Commit message should be rewritten enterily:
> > '''
> > This patch implemented the local subflow removing function,
> > mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_receiv=
ed
> > under the PM spin lock.
> >
> > We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
> > argument from remote_id to local_id.
> >
> > We check subflow->local_id in mptcp_pm_nl_rm_subflow_received to remove
> > a subflow.
> > '''
>
> As described in my previous message, I also applied this patch (without
> Paolo's ACK) because this was needed for the patch modifying the MIB.

This squash-to patch is fine, and I'm very confident about it. The new func=
tion
mptcp_pm_nl_rm_subflow_received is copied from mptcp_pm_nl_rm_addr_received,
there are only three differences between them:

1. mptcp_pm_nl_rm_subflow_received use rm_id as an input parameter, but
mptcp_pm_nl_rm_addr_received get rm_id from msk->pm.rm_id.

2. mptcp_pm_nl_rm_subflow_received check if the rm_id equals subflow's
local_id, but
mptcp_pm_nl_rm_addr_received check if it equals subflow's remote_id.

3. mptcp_pm_nl_rm_subflow_received reduce local_addr_used number, but
mptcp_pm_nl_rm_addr_received reduce add_addr_accepted number and set
accept_addr to true.

-Geliang



>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============6182889926667909805==--
