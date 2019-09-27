Content-Type: multipart/mixed; boundary="===============0664673908777929223=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Fri, 27 Sep 2019 17:02:00 +0200
Message-ID: <0be9a3a0-5ced-d826-3fbc-79d4da477e61@tessares.net>
In-Reply-To: 1a5101afdb6fa955835b7fd09ce56077abf2c1eb.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1937

--===============0664673908777929223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/09/2019 19:20, Paolo Abeni wrote:
> On Thu, 2019-09-26 at 17:05 +0200, Florian Westphal wrote:

[...]

>> from Paolo.
>>
>> But I figured it would make sense to share this now and discuss
>> how to proceed from here first.
> =

> The above branch is based on mptcp_net-next export branch hash
> a45bdbe6701b

Great, still the last one. So everything is in it.

> There is a small diff vs such hash, see below. Mostily checkpack fixes,
> a trivial functional fix in mptcp_setsockopt(), and a bunch of likely
> not interesting debug messages dropped - side note: we may want remove
> more of them.

I guess that we indeed need to remove most of these pr_debug() at some
points. Thank you for having done that!
Also great to have looked at checkpatch and making sure each commit can
compile :-)

For the fix in mptcp_setsockopt(), was it due to a bad "squash"?

For the diff, it looks good to me.

*@Peter/@Mat*: is it also OK for you?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0664673908777929223==--
