Content-Type: multipart/mixed; boundary="===============3384206351050132318=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests: test setsockopt(..., TCP_ULP,
 "mptcp", ...)
Date: Wed, 09 Oct 2019 09:52:44 +0200
Message-ID: <80aa086a-a1bd-7c26-65df-af3b26a35801@tessares.net>
In-Reply-To: 7cec08b00730e72fba12eb7839f1d3a075b96a4e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2067

--===============3384206351050132318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 08/10/2019 22:21, Paolo Abeni wrote:
> On Tue, 2019-10-08 at 17:00 +0200, Matthieu Baerts wrote:
>> Hi Davide,
>>
>> On 08/10/2019 16:43, Davide Caratti wrote:
>>> add a selftest to verify that the kernel forbids attaching MPTCP subflo=
ws
>>> to userspace TCP sockets with setsockopt(..., IPPROTO_TCP, TCP_ULP, ...=
).
>>
>> Good idea to have a test for that!
>>
>>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
>>> ---
>>>  .../selftests/net/mptcp/mptcp_connect.c       | 49 +++++++++++++++++--
>>>  .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
>>>  2 files changed, 65 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/=
testing/selftests/net/mptcp/mptcp_connect.c
>>> index cac71f0ac8f8..12a722e0c527 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>
>> [...]
>>
>>> @@ -114,6 +116,41 @@ static int sock_listen_mptcp(const char * const li=
stenaddr,
>>>  	return sock;
>>>  }
>>>  =

>>> +static bool sock_test_tcpulp(const char * const remoteaddr,
>>> +			     const char * const port)
>>> +{
>>> +
>>> +	struct addrinfo hints =3D {
>>> +		.ai_protocol =3D IPPROTO_TCP,
>>> +		.ai_socktype =3D SOCK_STREAM,
>>> +	};
>>> +	struct addrinfo *a, *addr;
>>> +	int sock =3D -1, ret =3D 0;
>>> +	bool test_pass =3D false;
>>> +
>>> +	hints.ai_family =3D AF_INET;
>>> +
>>> +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
>>> +	for (a =3D addr; a; a =3D a->ai_next) {
>>> +		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
>>> +		if (sock < 0) {
>>> +			perror("socket");
>>
>> Why could we have an error here? It is just to avoid error message in
>> the output for something we don't consider as an error.
> =

> It can fail e.g. due to memory pressure, or ulimits. Should never
> happen in normal circumstances, but I think it's better to catch this
> up, as this patch does.

Sorry, I should have added my comment at the next line. My question was
also: should we not "break" here in case of error?
But if should never fail, I guess we can still go to the next address.
As long as we don't have "useless" error messages each time we execute
the tests, I am then fine with both "break" and "continue" here.

>>> +			continue;
>>> +		}
>>> +
>>> +		ret =3D setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
>>> +				 sizeof("mptcp"));
>>> +		close(sock);
>>> +		if (ret =3D=3D -1) {
>>
>> Should we check errno as well? Just to be sure we are not "blocked" for
>> another reason.
> =

> I agree additionally checking errno =3D=3D -EOPNOTSUPP would be better.
> =

> Otherwise LGTM.
> =

> In the longer run we may consider moving this test and ev. diag, MIB,
> etc to a separate, functional-test binary/script, but I think this is
> good for now.

Good idea, I was thinking about the same thing yesterday. I can have a
look at this in the future if needed.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3384206351050132318==--
