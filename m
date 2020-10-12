Content-Type: multipart/mixed; boundary="===============4771871558729802141=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: mptcp: keep track of
 advertised windows right edge
Date: Mon, 12 Oct 2020 15:12:06 +0200
Message-ID: <23c6b7b5-dccd-f51c-8981-eae36a5e3555@tessares.net>
In-Reply-To: 20201005122833.GB5213@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6290

--===============4771871558729802141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 05/10/2020 14:28, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Move oow messages to debug: I guess we don't want to have this in
>> pr_info() :)
>> But maybe we don't want these info at all?
> =

> Right, pr_info is a bug.  I will continue to test a not-yet-sent
> patch that improves receive window tracking (i.e., what *WE* offered
> most recently to the peer), probably I can send it tomorrow afternoon.
> =

> This will add two new variables to msk: the real mptcp-level receive
> window announced, and the ack sequence number that was used as the
> reference point. Right now the codes uses ack_seq plus current space,
> and that is sometimes not in line with what we told the peer.

Thank you for your reply! That would be good to be in line with what we =

told the peer!
> I think its useful to have a pr_debug (then modified to include that
> information too).

As discussed at the last weekly meeting, we decided to apply the current =

patch and modify it later to include the new variable.

- c5d72b415ba2: "squashed" in "mptcp: keep track of advertised windows =

right edge"
- no co-dev/SOB added for that
- Results: faedb495716f..5a5a571a738c

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4771871558729802141==--
