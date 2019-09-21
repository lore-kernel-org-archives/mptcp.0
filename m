Content-Type: multipart/mixed; boundary="===============0842459417859478721=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Sat, 21 Sep 2019 12:32:58 +0200
Message-ID: <2a8cf15c-9429-76e5-78d3-c48330a182bd@tessares.net>
In-Reply-To: alpine.OSX.2.21.1909201543300.79505@tvtrimel-mobl5.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1899

--===============0842459417859478721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 21/09/2019 00:45, Mat Martineau wrote:
> =

> On Fri, 20 Sep 2019, Paolo Abeni wrote:
> =

>> Currently we can hit a stream's corruption with the following sequence:
>> - sendmsg_frag is invoked while the write_queue tail skb's len is
>> equal to
>> =C2=A0the current size_goal.
>> =C2=A0sendmsg_frag sets can_collapse to false, even if mptcp data are in
>> sequence.
>> =C2=A0Anyway it does not set eor in the write_queue skb.
>> - sendmsg_frag invokes do_tcp_sendmsg(), which tries to allocate a new
>> skb -
>> =C2=A0as the 'size_goal - skb->len <=3D 0' condition is true.
>> =C2=A0But it hits memory limit and/or such allocation fails, so
>> do_tcp_sendmsg()
>> =C2=A0jumps to the 'wait_for_memory:' label and invokes tcp_push()
>> - tcp_push() tries to transmit the write queue tail skb, but due to
>> window size
>> =C2=A0limit, split it, send the first half and leave in the write queue a
>> smaller
>> =C2=A0skb - without any ext attached
>> - do_tcp_sendmsg() invokes sk_stream_wait_memory and than checks again
>> for skb
>> =C2=A0allocation, this time skb->len is less than size_goal and
>> do_tcp_sendmsg()
>> =C2=A0collapse the data on the existing skb
>> - sendmsg_frag adds a new ext to the tail skb in write queue, but due
>> to the above
>> =C2=A0it is associated with a wrong/unexpected subflow sequence number: =
it
>> maps
>> =C2=A0a future ssn -> stream corruption
>>
>> This change addresses the above issue explicitly setting the 'eor'
>> when hitting
>> the initial condition so that tcp will not collapse the data after
>> tcp_push().
> =

> Thanks for the detailed description. Code looks good to me and tested
> fine (although failures remain, but I don't think this was intended to
> fix everything).

Thank you for this patch, the nice description and the review!

- ca356e76c1fe: "squashed" in "mptcp: allow collapsing consecutive
sendpages on the same substream"
- signed-off was already there
- 68f9e3f86b09: conflict in
t/mptcp-rework-mptcp_sendmsg_frag-to-accept-optional-dfrag
- 1b7998a9a0aa..782be479bf43: result

Here is the output of kselftest exec:

# MPTCP is disabled by default as expected	[ OK ]
# ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[ OK ]
# ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
# ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
# ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[ FAIL ] file received by
server does not match (in, out):
# -rw------- 1 root root 5095452 Sep 21 10:23 /tmp/tmp.zY3i7pjyW3
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 4900057 Sep 21 10:23 /tmp/tmp.6H8H1PP7hu
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns2  MPTCP -> ns1  (10.0.1.1:10016) MPTCP	[ OK ]
# ns2  MPTCP -> ns1  (10.0.1.1:10017) TCP  	[ OK ]
# ns2  TCP   -> ns1  (10.0.1.1:10018) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10019) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10020) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.1.2:10021) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10022) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10023) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.2.1:10024) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10025) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10026) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.2.2:10027) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10028) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10029) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.3.2:10030) MPTCP	[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10031) MPTCP	[ FAIL ] file received by
server does not match (in, out):
# -rw------- 1 root root 5095452 Sep 21 10:23 /tmp/tmp.zY3i7pjyW3
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 5049520 Sep 21 10:24 /tmp/tmp.6H8H1PP7hu
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns3  MPTCP -> ns1  (10.0.1.1:10032) MPTCP	[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10033) TCP  	[ OK ]
# ns3  TCP   -> ns1  (10.0.1.1:10034) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10035) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10036) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.1.2:10037) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10038) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10039) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.2.1:10040) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10041) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10042) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.2.2:10043) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10044) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10045) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.3.2:10046) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10047) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10048) TCP  	[ OK ]
# ns3  TCP   -> ns4  (10.0.3.1:10049) MPTCP	[ OK ]
# ns4  MPTCP -> ns1  (10.0.1.1:10050) MPTCP	[ FAIL ] file received by
client does not match (in, out):
# -rw------- 1 root root 2296860 Sep 21 10:23 /tmp/tmp.eiXCYMBq69
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 2241152 Sep 21 10:24 /tmp/tmp.ypdqO6UziE
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns4  MPTCP -> ns2  (10.0.1.2:10051) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.1.2:10052) TCP  	[ OK ]
# ns4  TCP   -> ns2  (10.0.1.2:10053) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.2.1:10054) MPTCP	[ FAIL ] file received by
client does not match (in, out):
# -rw------- 1 root root 2296860 Sep 21 10:23 /tmp/tmp.eiXCYMBq69
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 2254482 Sep 21 10:24 /tmp/tmp.ypdqO6UziE
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns4  MPTCP -> ns3  (10.0.2.2:10055) MPTCP	[ FAIL ] file received by
client does not match (in, out):
# -rw------- 1 root root 2296860 Sep 21 10:23 /tmp/tmp.eiXCYMBq69
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 2280476 Sep 21 10:25 /tmp/tmp.ypdqO6UziE
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns4  MPTCP -> ns3  (10.0.3.2:10056) MPTCP	[ FAIL ] file received by
client does not match (in, out):
# -rw------- 1 root root 2296860 Sep 21 10:23 /tmp/tmp.eiXCYMBq69
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 2212876 Sep 21 10:25 /tmp/tmp.ypdqO6UziE
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# ns4  MPTCP -> ns4  (10.0.3.1:10057) MPTCP	[ OK ]
# ns4  MPTCP -> ns4  (10.0.3.1:10058) TCP  	[ OK ]
# ns4  TCP   -> ns4  (10.0.3.1:10059) MPTCP	[ OK ]
not ok 1 selftests: mptcp: mptcp_connect.sh


Cheers,
Matt


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0842459417859478721==--
