Content-Type: multipart/mixed; boundary="===============7714824229250040037=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 2/4] imptcp: cleanup fallback handling
Date: Tue, 10 Dec 2019 15:30:16 +0100
Message-ID: <20191210143016.GL795@breakpoint.cc>
In-Reply-To: b6a7eee20776b33615a39b2607919e4e019b4ba6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2858

--===============7714824229250040037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-12-09 at 18:28 -0800, Mat Martineau wrote:
> > I did just say "locking looks ok", but just below this is some iteratio=
n =

> > over msk->conn_list without the msk lock held. The locking there is =

> > unaffected by your patch, but this might be a good chance to take a loo=
k =

> > at the locking around that list iteration!
> =

> Thank you for the feedback! I'll cope in the next iteration.
> =

> The lockless access to msk->conn_list requires a bit more changes, I'm
> unsure I can deal with that in a timely manner. I'll try. =

>
> Idea would be  dropping the intermendiate inet_accept() call and open-
> code part of it, so we don't have to acquire and release the locks
> multiple times.

What about delaying

inet_sk_state_store(newsk, TCP_ESTABLISHED);

until after this unlocked list iteration?

This would/should prevent any concurrent joins and thus any
list modifications.
--===============7714824229250040037==--
