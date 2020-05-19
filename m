Content-Type: multipart/mixed; boundary="===============6101606225461772799=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Tue, 19 May 2020 18:26:55 +0200
Message-ID: <dc80ead6-5b04-6fab-b9d7-a985f44657fc@tessares.net>
In-Reply-To: cc760b468795bc4a189b1e3e0c6ab22bfccad757.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4420

--===============6101606225461772799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Todd,

On 19/05/2020 18:00, Todd Malsbary wrote:
> Hi Matthieu,
> =

> On Tue, 2020-05-19 at 17:11 +0200, Matthieu Baerts wrote:
>> Hi Todd,
>>
>> On 19/05/2020 02:30, Christoph Paasch wrote:
>>> On 18/05/20 - 15:29:16, Todd Malsbary wrote:
>>>> This changes the HMAC used in the ADD_ADDR option from the leftmost 64
>>>> bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
>>>>
>>>> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
>>>
>>> Nice find!
>>
>> Yes, good catch!
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>
>> I guess we should send that to -net branch, ideally before the release
>> of v5.7, not to introduce incompatibilities between versions. What do
>> you think?
>>
> =

> Sounds good to me.  Just to double check on the process: send this
> patch out again to the netdev list with [PATCH net] as the prefix, and
> cc this list?

(We continued the discussion on IRC).
In short: yes but "Fixes" tag is required.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6101606225461772799==--
