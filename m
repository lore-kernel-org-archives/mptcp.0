Content-Type: multipart/mixed; boundary="===============7572387991814431878=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Tue, 17 Dec 2019 12:55:10 +0100
Message-ID: <f7220b4a-8777-d5cb-4f93-61abb3c7b273@tessares.net>
In-Reply-To: d5cedcefb8b96be1dc1835e5b5a0b0afc33eca03.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3112

--===============7572387991814431878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/12/2019 12:08, Paolo Abeni wrote:
> On Tue, 2019-12-17 at 11:02 +0100, Matthieu Baerts wrote:
>> move sk_type to a separate field to:
>> - avoid extra operations to fetch sk->sk_type on some arches (Eric)
>> - allow compilers to emit better code to access/manipulate native types
>>    compared to bitfields. (Paolo)
>>
>> Suggested-by: Eric Dumazet <edumazet(a)google.com>
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "sock: Make sk_protocol a 16-bit value"
>>
>>   include/net/sock.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 0930f46c600c..b93cadba1a3b 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -451,13 +451,13 @@ struct sock {
>>   #define SK_FL_TYPE_MASK    0xffff0000
>>   #endif
>>   =

>> -	unsigned int		sk_padding : 1,
>> +	u8			sk_padding : 1,
>>   				sk_kern_sock : 1,
>>   				sk_no_check_tx : 1,
>>   				sk_no_check_rx : 1,
>> -				sk_userlocks : 4,
>> -				sk_type      : 16;
>> +				sk_userlocks : 4;
>>   	u8			sk_pacing_shift;
>> +	u16			sk_type;
>>   	u16			sk_protocol;
>>   	u16			sk_gso_max_segs;
>>   	unsigned long	        sk_lingertime;
> =

> LGTM.

Thank you for the review and the suggestion not to simply move it to the =

beginning of the 'unsigned int' but to move it to a separated field.

- 32121b5387c7: "squashed" in "sock: Make sk_protocol a 16-bit value"
- 1e3599433335: "Signed-off-by" + "Co-developed-by"
- 3a1b579608d1..bf07050cd31b: result

Tests are still OK!

> @list, please do not reply directly to the orig messages, or trim the
> recipients list, as eric email address unintentionally slipped into it.

Sorry for that :(

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7572387991814431878==--
