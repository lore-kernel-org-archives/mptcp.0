Content-Type: multipart/mixed; boundary="===============7816712194766031835=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Wed, 24 Jun 2020 18:29:56 +0200
Message-ID: <58b3daa4-140c-0eba-9463-faa6aaf0ca09@tessares.net>
In-Reply-To: f32389b8a22047ec4c5366f8b8e76209512726b0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4784

--===============7816712194766031835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo

On 22/06/2020 16:51, Paolo Abeni wrote:
> On Mon, 2020-06-22 at 15:03 +0200, Florian Westphal wrote:
>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>> On Mon, 2020-06-22 at 13:18 +0200, Florian Westphal wrote:
>>>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>>>> I'm wondering if we should keep using an MPTCP-specific workqueue.
>>>>> Server side, we don't expect the work to trigger very often, but shou=
ld
>>>>> that ever happen, top will tell easily.
>>>>
>>>> You mean switch msk->work from system_wq to a custom workqueue?
>>>
>>> yep, e.g. reusing and renaming 'pm_wq'. When the PM works a lot (in
>>> "ndiffports" mode as in issues/33), the pm_wq is visible in top - at
>>> least in dbg build, I never tested with regular kconfig - and I like
>>> being able to identify it easily. WDYT?
>>
>> Can you do this?
> =

> I'll try to run the perf tests on non-debug build, but I see your
> point. Let's keep the patch simple - as is now. We can look for a
> workqueue only if mptcp workqueue usage proves to be relevant in non
> debug build.

Thank you for the patch and the review!

I just added this patch at the end of the series.

- bcb252d3443b: mptcp: use mptcp worker for path management

Tests and export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7816712194766031835==--
