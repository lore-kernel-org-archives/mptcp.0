Content-Type: multipart/mixed; boundary="===============4148574572304827105=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH] Squash-to: "mptcp: implement
 mptcp_pm_remove_subflow v9"
Date: Fri, 11 Sep 2020 08:45:07 +0200
Message-ID: <050f7802-d391-0278-7216-cd943d6191f6@tessares.net>
In-Reply-To: 5624c8ee7e6db4c20fa7f0593d2e6cc9be36ca32.1599546158.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5796

--===============4148574572304827105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 08/09/2020 08:32, Geliang Tang wrote:
> Commit message should be rewritten enterily:
> '''
> This patch implemented the local subflow removing function,
> mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_received
> under the PM spin lock.
> =

> We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
> argument from remote_id to local_id.
> =

> We check subflow->local_id in mptcp_pm_nl_rm_subflow_received to remove
> a subflow.
> '''

As described in my previous message, I also applied this patch (without =

Paolo's ACK) because this was needed for the patch modifying the MIB.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4148574572304827105==--
