Content-Type: multipart/mixed; boundary="===============1818881267345020922=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/6] mptcp: update mptcp ack sequence from work
 queue
Date: Fri, 21 Feb 2020 00:23:32 +0100
Message-ID: <20200220232332.GN19559@breakpoint.cc>
In-Reply-To: 20200220143426.28626-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3715

--===============1818881267345020922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> V3.  No changes since v2, I only updated commit messages in
> patches 1, 2, 3 and 6.
> =

> I think we should try to avoid needless squashing and keep
> these as-is for now.  We can always condense some of this later
> on in case we need to reduce number of individual patches for some
> reason.

As per yesterdays meeting, I've rebased this on top of net-next:

https://git.breakpoint.cc/cgit/fw/net-next.git/log/?h=3Dmptcp_ssk_drain_01

Paolo, I extracted the parts that add the work queue from your retrans
patch, I renamed the work queue because 'rtx_work' doesn't makse
sense if its not related to retransmits.

The patch is rather tiny so I wonder if it should be merged with the
main patch (mptcp: update mptcp ack sequence from work queue).

Let me know.

Also, I would propose to drop
"mptcp: protocol: re-check dsn before reading from subflow" before
sending this to netdev since that patch isn't related to the rest
of the patches.

It should probably be part of the batch after this, at the latest
it needs to go in when MP_JOIN support is added.

WDYT?

I can't post it to netdev yet anyway because I need to wait for
net -> net-next merge to avoid a small conflict in protocol.h, so
you can take your time with reviewing this.
--===============1818881267345020922==--
