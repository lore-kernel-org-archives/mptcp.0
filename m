Content-Type: multipart/mixed; boundary="===============7329142773742243997=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: better msk receive window updates
Date: Fri, 05 Feb 2021 09:26:51 +0100
Message-ID: <d19542587611b4c1b841e5e37c3d2432e516a59e.camel@redhat.com>
In-Reply-To: e81e1dd115ed490477390375b0122dae70e8d107.1612477178.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7632

--===============7329142773742243997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-04 at 23:23 +0100, Paolo Abeni wrote:
> Move mptcp_cleanup_rbuf() related checks inside the mentioned
> helper and extend them to mirror more closely TCP ones. To implement
> them we need to track the subflows mss and the ack_seq delta.
> Do not relay anymore on tcp_cleanup_rbuf() and send ack explicitly.

The more I think a about this, the more it looks like a workaround
instead of a real fix for the still vague root cause. Please keep this
on-hold.

> Additionally drop the 'rmem_pending' hack, since commit 879526030c8b
> ("mptcp: protect the rx path with the msk socket spinlock") we
> can use instead 'rmem_released'.

This part instead looks good and deserve a patch of its own.

/P


--===============7329142773742243997==--
