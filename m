Content-Type: multipart/mixed; boundary="===============2140035333494816478=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 16:36:55 +0100
Message-ID: <43b514ba-69b9-b103-1777-323daf209bc2@tessares.net>
In-Reply-To: c420dc6ea000ee8fa951ab89689b63785a4df0f7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2617

--===============2140035333494816478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 20/11/2019 16:25, Paolo Abeni wrote:
> On Wed, 2019-11-20 at 16:10 +0100, Florian Westphal wrote:
>> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>>> There were doubts as to the repeated invocations of mptcp_send_frag()
>>>> (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I have
>>>> dropped it from this iteration -- mptcp_sendmsg_frag needs rework which
>>>> isn't related to this patch series.
>>>
>>> The series looks good to me, with one minor comment on patch 1.
>>
>> Thanks, I can fix that up.
>>
>> How to proceed?  There are several patches in-flight.  I think it might
>> make sense to apply this series as-is, with no squashing.
> =

> I'm personally ok with that.
> =

> Can we wait for the series 'Awaiting Upstream' being applied, before
> going with this one?

I was replying to Florian to say that I was going to do that :)
I would like to apply these two series:

   https://patchwork.ozlabs.org/project/mptcp/list/?state=3D8&delegate=3D10=
0661

Ideally, I would also like to move commits after kselftests introduction =

but this can wait if needed.

> Than v1 support can be rebased on top of the resulting tree (still to
> be applied just before self-tests).
> =

>> We can then do another squash-marathon later on before next upstream
>> submission.
> =

> Yep, we will likely need some kind of "code-freeze", and squash/bugfix
> only before the submission.

We just need to be careful that if we add a lot of modifications at the =

end of the series, it can make other new patches difficult to squash =

(based on new code, we need to apply on older code, then resolve =

conflicts, etc.).

But I understand that it takes time to do that and we might want to =

postpone that. As long as it is not too long, otherwise we might have to =

queue a few patches for a future squash :)

If we agree to put these 13 patches at the end (+ the two to include =

MPTCPv1 support?), I can easily do that when I get the go!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2140035333494816478==--
