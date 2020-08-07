Content-Type: multipart/mixed; boundary="===============5172660100285719685=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix warn at shutdown time for
 unaccepted msk sockets
Date: Fri, 07 Aug 2020 09:36:01 -0700
Message-ID: <20200807163601.GT4579@MacBook-Pro-64.local>
In-Reply-To: 1a4636f016e3e8b7949380b5f4ab4e77ae3c316d.1596817055.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5514

--===============5172660100285719685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/07/20 - 18:17, Paolo Abeni wrote:
> With commit b93df08ccda3 ("mptcp: explicitly track the fully
> established status"), the status of unaccepted mptcp closed in
> mptcp_sock_destruct() changes from TCP_SYN_RECV to TCP_ESTABLISHED.
> =

> As a result mptcp_sock_destruct() does not perform the proper
> cleanup and inet_sock_destruct() will later emit a warn
> in ESTABLISHED status.
> =

> Address the issue updating the condition tested in mptcp_sock_destruct().
> Also update the related comment.
> =

> Fixes: b93df08ccda3 ("mptcp: explicitly track the fully established statu=
s")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/subflow.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Christoph Paasch <cpaasch(a)apple.com>



Christoph

--===============5172660100285719685==--
