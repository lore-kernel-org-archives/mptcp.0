Content-Type: multipart/mixed; boundary="===============8110212593826508256=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] net: mptcp: improve fallback to TCP
Date: Mon, 08 Jun 2020 13:57:16 +0200
Message-ID: <99dea26d-b085-e06a-9c82-ebbfcb58cd6a@tessares.net>
In-Reply-To: ac7bd6279c16821347f30edbd24fb4a333151d53.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4607

--===============8110212593826508256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo, Mat,

On 08/06/2020 12:16, Paolo Abeni wrote:
> On Fri, 2020-06-05 at 11:22 +0200, Davide Caratti wrote:
>> keep using MPTCP sockets and a "dummy mapping" in case of fallback to
>> regular TCP. Skip adding DSS option on send, if TCP fallback has been
>> done earlier.
>>
>> Notes: I'm unsure on what to do in mptcp_clean_una() to do a one-time
>> flush of the retransmit queue, as per Mat's suggestion. Any advice?
>>
>> Changes since v1
>>   - rebase on top of Paolo's fix for NULL dereference in mptcp_recvmsg()
>>
>> Changes since RFC v2:
>>   - use a bit in msk->flags, rather than a dedicated boolean in struct
>>     msk. This bit is going to be used in combination with another one,
>>     TCP_FALLBACK_ALLOWED, that is 1 at the first subflow creation
>>     and gets cleared once TCP fallback is no more allowed.
>>   - separate code that adds support for "infinite mapping", and use
>>     the term "dummy" instead of "infinite". Suggested by Mat
>>   - remove inappropriate call to __mptcp_do_fallback() in
>>     mptcp_accept() (Paolo)
>>
>> Changes since RFC v1:
>>   - use a dedicated member of struct msk to indicate that a fallback
>>     ha happened, use it in case of infinite mapping
>>   - don't delete skb_ext in case of infinite mapping (Mat)
>>   - test the value of pm.subflows on reception of an infinite map to
>>     ensure that no other subflow is currently opened (Mat)
>>   - in mptcp_established_options(), avoid adding TCP options in case
>>     of fallback indication; simplify sendmsg()/recvmsg()/poll() to
>>     keep using the MPTCP socket in case of TCP fallback. Set the
>>     fallback indication in case subflow is not mp_capable after
>>     successful 3-way handshake, instead of flipping 'is_mptcp'
>>     (Paolo/Mat)
>>   - remove deadcode in mptcp_finish_connect, and increment
>>     MPTCP_MIB_MPCAPABLEACTIVEFALLBACK in subflow_finish_connect
>>     (Paolo)
>>
>> BugLink: https://github.com/multipath-tcp/mptcp_net-next/issues/11
>> BugLink: https://github.com/multipath-tcp/mptcp_net-next/issues/22
>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

Thank you for the patch and the reviews!

This commit is now at the end of the export branch (before the two =

DO-NOT-MERGE ones), tests are all passing!

@Davide: do not hesitate to create a new PR for Packetdrill ;-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8110212593826508256==--
