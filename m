Content-Type: multipart/mixed; boundary="===============8118589197490387002=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Fri, 04 Sep 2020 18:40:20 +0200
Message-ID: <48bde311-49dd-2a75-8a6c-0df1b1286ee9@tessares.net>
In-Reply-To: 3ba08d7bad27095361fecc28af6c21ba25ecb3ac.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5725

--===============8118589197490387002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 03/09/2020 11:58, Paolo Abeni wrote:
> On Thu, 2020-09-03 at 00:01 +0200, Florian Westphal wrote:
>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>> On Wed, 2020-09-02 at 16:37 +0200, Florian Westphal wrote:
>>>> The function is short and won't sleep, so this can use the _fast versi=
on.
>>>>
>>>> Signed-off-by: Florian Westphal <fw(a)strlen.de>

(...)
>>> Good catch! the patch LGTM, thanks!
>>>
>>> Do you think it could useful do the same also in mptcp_sendmsg()
>>> and mptcp_worker()? (since mptcp_sendmsg_frag() does not sleep, should
>>> be possible...)
>>
>> sendmsg path might sleep  (it copies data from userspace).
> =

> Whoops I missed that.
> =

>> mptcp_worker might work, but I think we would need to make sure
>> mptcp_ext_cache_refill() uses atomic allocations for this to work.
>>
>> Not sure this is a good idea.  For work queue case I think its better
>> to try to make it a true slowpath that isn't invoked frequently.
> =

> Agreed, we really don't want to over-optimize the worker
> =

> I'm fine with this, thanks!

Thank you for the patch and the review!

Just added at the end of the series!

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8118589197490387002==--
