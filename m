Content-Type: multipart/mixed; boundary="===============0932960178591844808=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp:
 remove addr and subflow in PM netlink v9"
Date: Tue, 15 Sep 2020 15:04:39 +0200
Message-ID: <5817e524b9fc383bbc3a53915f58e71c40e87266.camel@redhat.com>
In-Reply-To: cover.1600170870.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5885

--===============0932960178591844808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-15 at 19:59 +0800, Geliang Tang wrote:
> v3:
>  - use "goto next" in mptcp_nl_remove_subflow_and_signal_addr
>  - update mptcp_destroy_common
> =

> v2:
>  - add mptcp_pm_remove_anno_addr and update logic in
>  mptcp_nl_remove_subflow_and_signal_addr
>  - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_destruct
>  - add mptcp_destroy_common helper
> =

> Geliang Tang (2):
>   Squash-to: "mptcp: remove addr and subflow in PM netlink"
>   mptcp: add mptcp_destroy_common helper
> =

>  net/mptcp/pm.c         |  1 +
>  net/mptcp/pm_netlink.c | 91 +++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.c   | 10 ++++-
>  net/mptcp/protocol.h   |  3 ++
>  net/mptcp/subflow.c    |  3 +-
>  5 files changed, 98 insertions(+), 10 deletions(-)
> =


Both patches LGTM, thanks!

Paolo

--===============0932960178591844808==--
