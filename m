Content-Type: multipart/mixed; boundary="===============6251744903942007410=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: mptcp: keep track of
 advertised windows right edge
Date: Mon, 05 Oct 2020 14:28:33 +0200
Message-ID: <20201005122833.GB5213@breakpoint.cc>
In-Reply-To: 20201005100040.1903854-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6199

--===============6251744903942007410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Move oow messages to debug: I guess we don't want to have this in
> pr_info() :)
> But maybe we don't want these info at all?

Right, pr_info is a bug.  I will continue to test a not-yet-sent
patch that improves receive window tracking (i.e., what *WE* offered
most recently to the peer), probably I can send it tomorrow afternoon.

This will add two new variables to msk: the real mptcp-level receive
window announced, and the ack sequence number that was used as the
reference point. Right now the codes uses ack_seq plus current space,
and that is sometimes not in line with what we told the peer.

I think its useful to have a pr_debug (then modified to include that
information too).

This would then allow to detect/debug if peer is really out of window
or if we announced a too large window.
--===============6251744903942007410==--
