Content-Type: multipart/mixed; boundary="===============0515947876324915574=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/8] mptcp: add ADD_ADDR port
 support for writing options
Date: Fri, 30 Oct 2020 17:14:51 -0700
Message-ID: <ef6b2cf7-6ff4-c0cf-da13-3974668a5715@linux.intel.com>
In-Reply-To: 9f367861-1410-e87-546a-b33c211f5f7d@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6500

--===============0515947876324915574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2020, Mat Martineau wrote:

>
> On Thu, 29 Oct 2020, Geliang Tang wrote:
>
>> This patch added ADD_ADDR port support for writing options.
>> =

>> In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
>> is 18 octets:
>>
>>                       1                   2                   3
>>   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>  +---------------+---------------+-------+-------+---------------+
>>  |     Kind      |     Length    |Subtype|(rsv)|E|  Address ID   |
>>  +---------------+---------------+-------+-------+---------------+
>>  |           Address (IPv4: 4 octets / IPv6: 16 octets)          |
>>  +-------------------------------+-------------------------------+
>>  |   Port (2 octets, optional)   |                               |
>>  +-------------------------------+                               |
>>  |                Truncated HMAC (8 octets, if E=3D0)              |
>>  |                               +-------------------------------+
>>  |                               |
>>  +-------------------------------+
>> =

>> But mptcp_write_options is 32-bit aligned, so we need to pad it to 20
>> octets.
>> =

>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>> include/net/mptcp.h  |  1 +
>> net/mptcp/options.c  | 64 +++++++++++++++++++++++++++++++++++++-------
>> net/mptcp/protocol.h | 10 +++----
>> 3 files changed, 60 insertions(+), 15 deletions(-)
>> =

>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index b6cf07143a8a..bb8b7b931490 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -46,6 +46,7 @@ struct mptcp_out_options {
>> #endif
>> 	};
>> 	u8 addr_id;
>> +	__be16 port;
>
> This should be a u16 (all the members in this struct use CPU byte order).=
 The =

> put_unaligned_be16() calls below also assume this is in CPU order.
>

Looking at later patches in the patch set, I see now that __be16 is used =

in other places for the port number. __be16 is also used for inet_dport in =

various places. We should make sure the port number is handled =

consistently within the MPTCP code, and to make sure it is also consistent =

with the other IP code. Anyone else have an opinion here?

If you keep using __be16, it does remain an issue that you don't want to =

use get_unaligned_be16() and put_unaligned_be16() with that data type.

--
Mat Martineau
Intel
--===============0515947876324915574==--
