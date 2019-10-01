Content-Type: multipart/mixed; boundary="===============8735677948423874613=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 17:14:41 +0200
Message-ID: <4a7f4996-eac5-2601-2a8f-ff720b9bec4f@tessares.net>
In-Reply-To: 20191001150035.GE14819@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1953

--===============8735677948423874613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for your answer!

On 01/10/2019 17:00, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> At the last meeting, we said it would be good to send a new RFCv2 to
>> netdev before the next meeting while windows are closed. I guess today
>> would be good, no?
> =

> Thanks for bringing this up.
> =

>> What do we still need to do?
>> - the cover letter: Mat is it still OK to do it on your side?
>> - any other patches to apply before this?
> =

> I think current export branch is fine for RFCv2.
> =

>> Here are the pending patches:
> [..]
> =

>> - mptcp: Remove all traces of checksum support: do we want it?
> =

> Do you mean in general or for RFC?
> =

> For RFC I think it depends on how much work you want to
> get yourself into right now, as it would need to be squashed, sending
> it as extra patch is strange.

In general. It is linked to my message I sent on the thread linked to
the patch:

=3D=3D=3D=3D

> On my side, I was looking at applying this patch. And after having
> split it in 5 smaller patches and starting applying half of them, I
> don't know if it is a good idea to fully drop the checksum (partial)
> support.
>
> The main part of this patch is removing the parsing of the checksum
> option. But in the commits where this is introduced, we also parse
> other possible options we could have and we act differently if one
> option is not supported. And in these commits, it makes sense to do
> that.
>
> We could see that as "we are parsing stuff we don't need". But we are
> already doing that for the "backup" bit for example. Or for the
> "MP_JOIN" while we don't support it when subflow_request_sock
> structure is introduced, etc.
>
> In other words, do we really need to remove this code linked to the
> checksum? If we plan never to support it, it makes sense. But I guess
> in the near future, we will want to support it, no?
>
> So should I continue applying this patch?

=3D=3D=3D=3D

But I can continue to apply it, I already did the splitting work. But I
preferred to raise the question now to avoid a revert of all of this :)

> =

>> - mptcp: add MIB counter infrastructure: Waiting for accept (last review)
>> - mptcp: allow MPTCP sockets by default: can be applied
>> - mptcp: prefix mptcp_ to exposed pm_ routines.
> =

> These three would be nice to have for sure.

I can work on that! (Once the first one is accepted :) )

>> For the moment, I am blocked with "mptcp: Remove all traces of checksum
>> support" but I can drop this rebase to work on other patches if others
>> are required for the RFCv2.
>>
>> What's your point of view on this?
> =

> I think merging in the checksum support remove before RFCv2 and the
> other three (MIB, mptcp-enable-by-default, mptcp_pm_ prefix) would be
> great.  I think its even ok to delay the series for a few days to get
> those in.

If we have an agreement on the patch removing the checksum support, I
can apply everything needed tomorrow and the whole patch-set can be sent
during the evening/night for us if it is OK for Mat!

> Let me know if i can help.

Thank you!
It should be fine for me to apply the different patches :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8735677948423874613==--
