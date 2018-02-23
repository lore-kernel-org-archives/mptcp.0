Content-Type: multipart/mixed; boundary="===============0364370634919133706=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Fri, 23 Feb 2018 12:20:03 -0800
Message-ID: <alpine.OSX.2.21.1802231158280.30876@gaoyuche-mobl.amr.corp.intel.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 311

--===============0364370634919133706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 22 Feb 2018, rao.shoaib(a)oracle.com wrote:

> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>
> Following patches modify TCP code to enable implementation of MPTCP. =

> MPTCP implementation requires sharing of TCP code with minor =

> modification here and there. In order to keep the TCP code clean and =

> easy to maintain, common code has been moved to new functions for use by =

> both TCP and MPTCP. struct tcp_sock now has function pointers and based =

> on the socket type (TCP/MPTCP) appropriate function is called.
>
> A basic implementation of MPTCP that works with IPv4/IPv6 and supports =

> join has been tested based on these changes.
>
> The changes are being submitted as an RFC to get feedback from the =

> community and to start a discussion on how to move forward.
>

Hi Rao -

I'd encourage you to closely read David Miller's response =

(https://www.spinics.net/lists/netdev/msg481868.html) to the TCP-MD5 RFC =

patch set that Christoph posted. We proposed some targeted indirect calls =

to callbacks for handling TCP options. He said "Sorry, I'm really not =

thrilled about this", and was focused on the performance implications of =

those callbacks. Have you looked at the performance and memory impact of =

adding indirection to a few dozen core TCP function calls?

To give some more background, when Christoph was crafting the MD5 patch =

set I pushed to take out some static-branch code that needed some work but =

eliminated the impact of the added callbacks for normal TCP. David focused =

on exactly that issue and didn't dive in to other aspects of the code. I =

can't fault him for that - he sorts through a staggering volume of patches =

every day, and if there's an issue that's clear at a glance it will pull =

all attention from the rest of the proposal. Also consider that Christoph =

replied with a few more questions, but the discussion stalled.

I do have more to say about the proposed architecture and how to structure =

the patch set for netdev - but I think the maintainer feedback we already =

have about indirect callbacks is most critical to consider and factor in =

to what we send to netdev in the future. We have the shared goal to get =

MPTCP in to the upstream kernel and it's going to take a coordinated =

community to get there!


Thanks,
Mat

--
Mat Martineau
Intel OTC

--===============0364370634919133706==--
