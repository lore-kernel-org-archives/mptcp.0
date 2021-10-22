Received: from ma1-aaemail-dr-lapp01.apple.com (ma1-aaemail-dr-lapp01.apple.com [17.171.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AD72
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 17:43:32 +0000 (UTC)
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
	by ma1-aaemail-dr-lapp01.apple.com (8.16.0.42/8.16.0.42) with SMTP id 19MG94D3010359;
	Fri, 22 Oct 2021 09:10:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=mbV8F+xn8MFOslAogADmR7MmVL5nElQDbgC5vg+OdJM=;
 b=jaFXJonVS09+Ysx6fC5GPDNVOqGoigQ3rTroZ35mOfIr4OmeUOx+C58d8wJc4IYaIaFJ
 IzXQp/vwoQ6Eoe1rPd0jOWCft8HaWwmnjGKfVP51IKinv4hP/KE/pqzxIhtG541vuNhK
 jfMV3m7MXyQFYq9rdoQco0FiEcd9Pk8B0sVzAtbw0cWQ7XFWBZDo8qPq6M8SCCN1EO98
 meFKrrTKOTXspXvGcQonShpMuH4eOCisR/oWNcKkaHksmqk8wZxbKsya4QP2yAsYL/w7
 O0BHGxdiLuOdDCMIrf438BVc95kaomXjMcSGSFDcpXLChRo/9zZRmHTrC7glN9HApjpK KQ== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
	by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 3bqwd659xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Fri, 22 Oct 2021 09:10:16 -0700
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.12.20210903 64bit (built Sep  3
 2021)) with ESMTPS id <0R1D00SIOZL3E5L0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Fri, 22 Oct 2021 09:10:15 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.12.20210903 64bit (built Sep  3
 2021)) id <0R1D00H00ZD05I00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Fri,
 22 Oct 2021 09:10:15 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: e93e8d760996af5a2afab1c31269e637
X-Va-E-CD: bcd2a47c6ff264a09681bcc5bd805462
X-Va-R-CD: c78c367312eb1db39e642561f0a4ef93
X-Va-CD: 0
X-Va-ID: e3e58776-8ffd-459e-97f0-aa47f3e52991
X-V-A: 
X-V-T-CD: e93e8d760996af5a2afab1c31269e637
X-V-E-CD: bcd2a47c6ff264a09681bcc5bd805462
X-V-R-CD: c78c367312eb1db39e642561f0a4ef93
X-V-CD: 0
X-V-ID: e4fdbd8d-0477-4f5f-a668-beaed3f65c04
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-22_04:2021-10-22,2021-10-22 signatures=0
Received: from smtpclient.apple ([17.11.130.153])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.12.20210903 64bit (built Sep  3
 2021))
 with ESMTPSA id <0R1D00B76ZL2LF00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Fri,
 22 Oct 2021 09:10:15 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: infinite mapping receiving"
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <ef557ead-87c8-8fbe-cca1-63396bdb8f40@linux.intel.com>
Date: Fri, 22 Oct 2021 09:10:14 -0700
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <DEA13B0F-B535-42A3-95C6-595859A1CD55@apple.com>
References: 
 <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
 <ef557ead-87c8-8fbe-cca1-63396bdb8f40@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-22_04:2021-10-22,2021-10-22 signatures=0

Hello,

> On Oct 21, 2021, at 6:06 PM, Mat Martineau =
<mathew.j.martineau@linux.intel.com> wrote:
>=20
> On Thu, 21 Oct 2021, Geliang Tang wrote:
>=20
>> Please update the commit log too:
>>=20
>> '''
>> This patch added the infinite mapping receiving logic.
>>=20
>> In mptcp_incoming_options(), invoke the new helper function
>> mptcp_infinite_map_received() to check whether the infinite mapping
>> is received. If it is, set the infinite_map flag of struct mptcp_ext.
>>=20
>> In get_mapping_status(), if the infinite mapping is received, set the
>> map_data_len of the subflow to 0.
>>=20
>> In subflow_check_data_avail(), only reset the subflow when the =
map_data_len
>> of the subflow is non-zero.
>> '''
>>=20
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> net/mptcp/options.c | 16 +++++++++++++---
>> net/mptcp/subflow.c |  2 +-
>> 2 files changed, 14 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index f4591421ed22..0144cc97a123 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1077,6 +1077,14 @@ static bool add_addr_hmac_valid(struct =
mptcp_sock *msk,
>> 	return hmac =3D=3D mp_opt->ahmac;
>> }
>>=20
>> +static bool mptcp_infinite_map_received(struct =
mptcp_options_received *mp_opt)
>> +{
>> +	if (mp_opt->use_map && !mp_opt->data_len)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> /* Return false if a subflow has been reset, else return true */
>> bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>> {
>> @@ -1085,7 +1093,9 @@ bool mptcp_incoming_options(struct sock *sk, =
struct sk_buff *skb)
>> 	struct mptcp_options_received mp_opt;
>> 	struct mptcp_ext *mpext;
>>=20
>> -	if (__mptcp_check_fallback(msk)) {
>> +	mptcp_get_options(sk, skb, &mp_opt);
>=20
> Now this will scan through all TCP options on every packet after =
fallback, to catch a rare infinite mapping in a case where we are only =
looking for one after sending MP_FAIL. While it's not super expensive, =
it's still extra work that adds up over the life of a connection. More =
importantly, I think this is showing how infinite mapping fallback is =
probably more complicated than I thought.
>=20
>=20
> For "infinite mapping fallback", there seem to be two separate parts =
of fallback to keep track of:
>=20
> * Transmit fallback: This peer has sent an infinite mapping already
>   (after receiving an MP_FAIL) and should not send any new MPTCP =
options.
>=20
> * Receive fallback: This peer has received an infinite mapping, and =
will
>   ignore MPTCP options on all incoming packets.
>=20
> The RFC does say that a receiver of MP_FAIL must send an MP_FAIL so =
both directions fall back, but with packets in flight there's still some =
time where fallback has only happened in one direction:
>=20
> 1. Peer A sends MP_FAIL
> 2. Peer B receives MP_FAIL
> 3. Peer B sends MP_FAIL (on an ack or data packet) and infinite =
mapping (on next data packet)
>   * Peer B enters "transmit fallback" at this time.
> 4. Peer A receives MP_FAIL, sends infinite mapping on next data =
packet.
>   * Peer B enters "transmit fallback" when sending infinite mapping
> 5. Peer A receives infinite mapping
>   * Peer A enters "receive fallback", fallback complete on this peer
> 6. Peer B receives infinite mapping
>   * Peer B enters "receive fallback", fallback complete on this peer
>=20
> Steps 4 and 5 could be reversed, we can't assume which order Peer B =
will send the mapping and the MP_FAIL.
>=20
> Another layer of complexity is that MP_FAIL can be lost if it's not in =
a data packet, so we probably need to keep sending MP_FAIL until an =
infinite mapping is received (like multipath-tcp.org does). This also =
implies that the receive code should ignore repeated MP_FAILs.
>=20
>=20
>=20
> I also noticed that the multipath-tcp.org kernel does something =
interesting with connections that are entering fallback with MP_FAIL: =
packets that contain a regular mapping (not infinite) are dropped after =
MP_FAIL is sent but an infinite mapping has not been received yet. Look =
at mptcp_detect_mapping() and "Ignore packets which do not announce =
fallback" comment text in mptcp_input.c.
>=20
> I think the reasoning may be that the bad checksum that triggered the =
MP_FAIL has dropped some data, so to get the data stream back in a good =
state we need to wait for the infinite mapping as a signal that the =
other peer received the MP_FAIL and has resent data starting from the =
last DATA_ACKed byte.
>=20
> @Christoph, does that sound correct? ^^^^
> 'git blame' said I should ask you :)

:) Yes, this sounds correct to me!

In general, fallback to infinite mid-stream is really a best-effort =
thing. Don't spend CPU-cycles on that in the fast-path :) It happens =
only if middleboxes start interfering with the data-stream in a very =
disruptive way. It's ok to try to work-around these things but not at =
any cost. Better to kill the connection and fail hard.

The fallback scenarios that are more common are the ones during =
connection establishment. Also, right after the TCP-handshake is a =
scenario that does happen.


Christoph

>=20
>> +
>> +	if (__mptcp_check_fallback(msk) && =
!mptcp_infinite_map_received(&mp_opt)) {
>> 		/* Keep it simple and unconditionally trigger send data =
cleanup and
>> 		 * pending queue spooling. We will need to acquire the =
data lock
>> 		 * for more accurate checks, and once the lock is =
acquired, such
>> @@ -1099,8 +1109,6 @@ bool mptcp_incoming_options(struct sock *sk, =
struct sk_buff *skb)
>> 		return true;
>> 	}
>>=20
>> -	mptcp_get_options(sk, skb, &mp_opt);
>> -
>> 	/* The subflow can be in close state only if =
check_fully_established()
>> 	 * just sent a reset. If so, tell the caller to ignore the =
current packet.
>> 	 */
>> @@ -1202,6 +1210,8 @@ bool mptcp_incoming_options(struct sock *sk, =
struct sk_buff *skb)
>>=20
>> 		if (mpext->csum_reqd)
>> 			mpext->csum =3D mp_opt.csum;
>> +		if (mptcp_infinite_map_received(&mp_opt))
>> +			mpext->infinite_map =3D 1;
>> 	}
>>=20
>> 	return true;
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 9e54122f18f4..bb7d8685ffd4 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -938,7 +938,7 @@ static enum mapping_status =
get_mapping_status(struct sock *ssk,
>> 	if (!skb)
>> 		return MAPPING_EMPTY;
>>=20
>> -	if (mptcp_check_fallback(ssk))
>> +	if (mptcp_check_fallback(ssk) && !mptcp_check_infinite_map(skb))
>> 		return MAPPING_DUMMY;
>>=20
>> 	mpext =3D mptcp_get_ext(skb);
>> --=20
>> 2.26.2
>=20
> --
> Mat Martineau
> Intel

