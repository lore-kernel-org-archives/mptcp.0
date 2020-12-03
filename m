Content-Type: multipart/mixed; boundary="===============3279742066975525035=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/2] remove address when
 netlink flush addrs and testcase
Date: Thu, 03 Dec 2020 15:46:03 +0100
Message-ID: <b732928d7500e649c7f63496d29d09ca3241a87e.camel@redhat.com>
In-Reply-To: cover.1606719598.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7024

--===============3279742066975525035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-30 at 15:11 +0800, Geliang Tang wrote:
> v2:
>  - update the testcase.
> =

> This patchset removes address when netlink do flush addrs command, and
> adds the testcase for flush addrs command.
> =

> Geliang Tang (2):
>   mptcp: remove address when netlink flush addrs
>   selftests: mptcp: add the flush addrs testcase
> =

>  net/mptcp/pm_netlink.c                        | 15 ++++--
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
>  2 files changed, 46 insertions(+), 19 deletions(-)

Both patches LGTM, thanks!

Paolo

--===============3279742066975525035==--
