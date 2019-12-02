Content-Type: multipart/mixed; boundary="===============5004657441967885040=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 8/9] subflow: place further subflows on new
 'join_list'
Date: Mon, 02 Dec 2019 17:56:31 +0100
Message-ID: <20191202165631.GP795@breakpoint.cc>
In-Reply-To: ef99ffecef8739ab5b90e6cec093547e86206887.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2743

--===============5004657441967885040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Not done yet:
> > 1. extend mptcp worker to collect timed-out entries
> > 2. prevent arbitrary growth of pending ssks.
> =

> Uhm... am I correct, the above will always happen if the client send
> [multiple] MP_JOIN at synack reception time? what can we do to prevent
> that? scheduling a cleanup workqueue on error?

We can't prevent it, client could flood us with hundreds of joins.

I think its best if we just add a upper ceiling on both
join and conn lists.

As for cleanup, I think we could have the rtx worker scan the
list for timed-out/"dead" joins.

--===============5004657441967885040==--
