Content-Type: multipart/mixed; boundary="===============6802272415472400673=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:pm: use mptcp_pm_init
Date: Tue, 15 Oct 2019 16:55:04 +0200
Message-ID: <3c470d07-0539-317e-c890-0fd8b627e71d@tessares.net>
In-Reply-To: fe1ed75afe43826752372f406bbd7d0b135f4d11.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2149

--===============6802272415472400673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 15/10/2019 16:49, Paolo Abeni wrote:
> On Tue, 2019-10-15 at 16:06 +0200, Matthieu Baerts wrote:
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3cef22193035..00ab1e7674eb 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1033,6 +1033,7 @@ void __init mptcp_init(void)
>>   	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
>>   =

>>   	mptcp_subflow_init();
>> +	mptcp_pm_init();
> =

> uhmm.. it looks like this chunk will conflict ?!? I see:
> =

> 	mptcp_subflow_init();
> 	mptcp_basic_init();
> =

> in the current git tree.

This patch is based on top of "mptcp: Add path manager interface" to =

avoid a conflict when applying it. I will indeed have a conflict when =

propagating this but I prefer not to have conflicts when applying the =

patch :)

> Otherwise LGTM

Thank you for the review!

Because I did patches from different bases, I didn't group these 3 =

patches. I will then wait for the review of the other patches to apply =

them all in one :)

Cheers,
Matt

> Thanks,
> =

> Paolo
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6802272415472400673==--
