Content-Type: multipart/mixed; boundary="===============2794787657845823674=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: disable two unstable mptcp_join tests
Date: Mon, 02 Mar 2020 17:07:29 +0100
Message-ID: <b2cf7a3358172f0a7b9aae6223dfb9d48950438c.camel@redhat.com>
In-Reply-To: 20200302160307.2108790-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3844

--===============2794787657845823674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-02 at 17:03 +0100, Matthieu Baerts wrote:
> They are currently unstable. Paolo is looking at them.
> =

> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Fixes: a17132c420b0 (selftests: add test-cases for MPTCP MP_JOIN)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Well, they are actually stable: they fail with 100% accuracy ;)

Looking to re-enable them ASAP, but will take time (we need correct and
accurate fourth ack handling/3rd ack retransmission)

The patch LGTM!

Cheers,

Paolo

--===============2794787657845823674==--
