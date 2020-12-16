Content-Type: multipart/mixed; boundary="===============5420298647561396818=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/4] mptcp: properly annotate nested lock
Date: Wed, 16 Dec 2020 15:37:06 -0800
Message-ID: <d21776-ebe6-37c6-5ab0-d04983b4c922@linux.intel.com>
In-Reply-To: 0cbf6359084bee1187ba382a015d8809e2ce2416.1608114076.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7201

--===============5420298647561396818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 16 Dec 2020, Paolo Abeni wrote:

> MPTCP closes the subflows while holding the msk-level lock.
> While acquiring the subflow socket lock we need to use the
> correct nested annotation, or we can hit a lockdep splat
> at runtime.
>
> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5420298647561396818==--
