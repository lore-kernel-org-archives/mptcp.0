Content-Type: multipart/mixed; boundary="===============5368324696334143809=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: possible deadlock in ipv6_sock_mc_close
Date: Mon, 01 Mar 2021 15:25:23 +0100
Message-ID: <52f32eac6b3ee60b236d24c48f69d7e79db39013.camel@redhat.com>
In-Reply-To: 5e22fa38-59be-397b-e800-db5f3de0c6b1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7972

--===============5368324696334143809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-01 at 14:58 +0100, Matthieu Baerts wrote:
> This report from syzbot mentioned an possible deadlock with MPTCP =

> socket. I don't know if the commit from nfsd is really causing that.
> =

> I'm then sharing this with the list just in case someone saw similar =

> issues :)

Looks like the deadlock report is valid, we should not invoke
ipv6_sock_mc_close() under the socket lock.

I'm unsure why syzbot bisect to an nfs commit.

I'll test a fix via syzbot soon.

/P

--===============5368324696334143809==--
