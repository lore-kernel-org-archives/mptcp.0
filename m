Content-Type: multipart/mixed; boundary="===============6900231370518677634=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 17:07:24 +0200
Message-ID: <405a1158-e814-af18-80da-59fc7369070f@tessares.net>
In-Reply-To: 933b5545ffbbf3c207c4880953b01cc7302fb4c4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1952

--===============6900231370518677634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for your answer!

On 01/10/2019 16:58, Paolo Abeni wrote:
> Hi,
> =

> Thank you for raising this topic!
> =

> On Tue, 2019-10-01 at 16:37 +0200, Matthieu Baerts wrote:
>> At the last meeting, we said it would be good to send a new RFCv2 to
>> netdev before the next meeting while windows are closed. I guess today
>> would be good, no?
> =

> Agreed ;)
> =

>> What do we still need to do?
>> - the cover letter: Mat is it still OK to do it on your side?
>> - any other patches to apply before this?
> =

> I personally think we can go even with the current git tree.
> If we want to flush part of the pending backlog I would go only for
> already accepted patches:
> =

> [...]
>> - mptcp: allow dumping subflow context to userspace: can be applied
>> - mptcp: allow MPTCP sockets by default: can be applied
> =

> The above ones: ^^^
> =

> The above to avoid possible last minute issues.

Make sense, thank you!
So better for you to wait before removing traces of the Checksum then?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6900231370518677634==--
