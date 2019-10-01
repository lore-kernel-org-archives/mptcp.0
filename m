Content-Type: multipart/mixed; boundary="===============6018287664684313246=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Remove all traces of checksum support
Date: Tue, 01 Oct 2019 14:14:36 +0200
Message-ID: <6fa56a27-10f0-fe52-fde2-2a2472780e4c@tessares.net>
In-Reply-To: a60dc7d1c6a6b010292340a47a437b9cb0e55007.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1975

--===============6018287664684313246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Peter,

On 30/09/2019 16:08, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-09-25 at 16:44 -0700, Peter Krystad wrote:
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index f1f5ab3990ab..400fbb0060f3 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -173,7 +173,7 @@ struct subflow_request_sock {
>>  	struct	tcp_request_sock sk;
>>  	u8	mp_capable : 1,
>>  		mp_join : 1,
>> -		checksum : 1,
>> +		unused : 1,
>>  		backup : 1,
>>  		version : 4;
>>  	u8	local_id;
> =

> Sorry I did not notice this beforehand. It looks a little strange to me
> creating a new struct with some 'unused' field. But I think is not
> blocking: we can merge the patch as-is and ev. drop the field later -
> if there is agreement on that.

I agree that it is certainly better to remove it in this context.

On my side, I was looking at applying this patch. And after having split
it in 5 smaller patches and starting applying half of them, I don't know
if it is a good idea to fully drop the checksum (partial) support.

The main part of this patch is removing the parsing of the checksum
option. But in the commits where this is introduced, we also parse other
possible options we could have and we act differently if one option is
not supported. And in these commits, it makes sense to do that.

We could see that as "we are parsing stuff we don't need". But we are
already doing that for the "backup" bit for example. Or for the
"MP_JOIN" while we don't support it when subflow_request_sock structure
is introduced, etc.

In other words, do we really need to remove this code linked to the
checksum? If we plan never to support it, it makes sense. But I guess in
the near future, we will want to support it, no?

So should I continue applying this patch? :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6018287664684313246==--
