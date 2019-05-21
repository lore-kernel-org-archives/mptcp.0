Content-Type: multipart/mixed; boundary="===============1602663923729704120=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [GIT] Sync with net-next: conflict
Date: Tue, 21 May 2019 16:09:09 +0200
Message-ID: <19598e54-ed65-a32f-26ae-b2b06193dd58@tessares.net>
In-Reply-To: f22b9f0c6f2ab53325570a0b2427279c7d04929b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1209

--===============1602663923729704120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 21/05/2019 16:03, Paolo Abeni wrote:
> Hi,
> =

> On Tue, 2019-05-21 at 14:26 +0200, Matthieu Baerts wrote:
>>
>> The commit 8b2e02e94442 (tcp: clean ext on tx recycle) from Paolo was
>> conflicting with a new one from upstream:  (tcp: do not
>> recycle cloned skbs) from Eric Dumazet.
>>
>> I simply added the new condition (&& !skb_cloned(skb)). I hope it is
>> alright: a73376082e4c6e3c9a48fd887f759ab1e4118477
> =

> The conflict resolution LGTM, thanks!
> =

> Not sure if the following actually makes any sense, if the merge commit
> could be squashed into "tcp: clean ext on tx recycle" that would
> simplify/cleanup the git history.

Sorry, the commit I mentioned is one from the topgit tree. During the
export, it is "squashed" correctly:

https://github.com/multipath-tcp/mptcp_net-next/commit/eddf1c63aa7f38237663=
8ab96082dc773c30eb50

Is it fine for you?

Cheers,
Matt

> Cheers,
> =

> Paolo
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1602663923729704120==--
