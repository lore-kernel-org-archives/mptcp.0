Received: from rn-mailsvcp-ppex-lapp14.apple.com (rn-mailsvcp-ppex-lapp14.rno.apple.com [17.179.253.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F12573
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 16:38:01 +0000 (UTC)
Received: from pps.filterd (rn-mailsvcp-ppex-lapp14.rno.apple.com [127.0.0.1])
	by rn-mailsvcp-ppex-lapp14.rno.apple.com (8.16.1.2/8.16.1.2) with SMTP id 28KGXAE0002162;
	Tue, 20 Sep 2022 09:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=h4r2hMFJNyPVlvMLe4joFevGus58rO/DgTXLMGbDjM0=;
 b=DZkg7NEeBH2GeE/UaoOtwvGHYByETLNCqGz1IXvbB4EmR1enffcBKAIPwv80E0OvdyrO
 bSIFTAeoJLN2pqrfE2AMfGsiSHT9T0yFkB5odJEIZT5Z1WhhdIcJlqafCYfWM2quIbxS
 FXcaM1fstA7qNLo06gzSvAGNFVCp7r4DQF3QwjgcAxBKB4SV1UK38uJqFY1heZpVC69r
 lUjOURRrZR0GQzRWqIBBSAbpquw2lTPIgT2BH1pr8tvVgB9N3xaj+KZN/B5NB20LSRCZ
 JEBaXd5L9qiVvX9qxE8c9UYvitHk6JaZHiHi60mFOQkTfpGAs/KSAUp+BnYQEuwetyu9 Ag== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
	by rn-mailsvcp-ppex-lapp14.rno.apple.com with ESMTP id 3jnx580txh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 20 Sep 2022 09:33:10 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.19.20220711 64bit (built Jul 11
 2022)) with ESMTPS id <0RII00T6ION6UL30@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Tue, 20 Sep 2022 09:33:07 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.19.20220711 64bit (built Jul 11
 2022)) id <0RII00200OKCQA00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 20 Sep 2022 09:33:06 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 01c79c26c92ba091f265afffa3a1e3a2
X-Va-R-CD: 3411ee3ee7283edb984b5c5043a25b96
X-Va-CD: 0
X-Va-ID: 0c0911fd-5e88-4b4e-b32d-410e70f28677
X-V-A: 
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 01c79c26c92ba091f265afffa3a1e3a2
X-V-R-CD: 3411ee3ee7283edb984b5c5043a25b96
X-V-CD: 0
X-V-ID: 629c5467-fe72-417e-aa5c-692d5b5f4764
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.528,18.0.895
 definitions=2022-09-20_07:2022-09-20,2022-09-20 signatures=0
Received: from smtpclient.apple (unknown [17.192.155.143])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.19.20220711 64bit (built Jul 11
 2022))
 with ESMTPSA id <0RII00OFAON6DE00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 20 Sep 2022 09:33:06 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.200.64.1.2\))
Subject: Re: [RFC PATCH mptcp-next v7 07/11] mptfo variables for msk,
 options. Fix loop retrans
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <d2dbb643e29250730a2610986cde88c188986c3b.camel@redhat.com>
Date: Tue, 20 Sep 2022 09:32:56 -0700
Cc: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <98630039-4188-4413-9A7D-D2A3A15A224C@apple.com>
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-8-dmytro@shytyi.net>
 <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
 <d2dbb643e29250730a2610986cde88c188986c3b.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.200.64.1.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.528,18.0.895
 definitions=2022-09-20_06:2022-09-20,2022-09-20 signatures=0

Hello Paolo,

> On Sep 19, 2022, at 4:26 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On Mon, 2022-09-19 at 13:11 +0200, Paolo Abeni wrote:
>> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>>> Introduce mptfo variables for msk and options.
>>> Also fixe the infinite retransmissions in the end of second session.
>>> Suggestion @palbeni (SEP 1) during the meting to 'look at ack'
>>>=20
>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>>> ---
>>> net/mptcp/fastopen.c | 16 ++++++++++++++++
>>> net/mptcp/options.c  |  3 +++
>>> net/mptcp/protocol.h |  6 +++++-
>>> 3 files changed, 24 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>>> index 436e773d798a..149a4b1d3dac 100644
>>> --- a/net/mptcp/fastopen.c
>>> +++ b/net/mptcp/fastopen.c
>>> @@ -91,3 +91,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct =
mptcp_sock *msk, sockptr_t optval,
>>>=20
>>> 	return ret;
>>> }
>>> +
>>> +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct =
mptcp_subflow_context *subflow,
>>> +				     struct mptcp_options_received =
mp_opt)
>>> +{
>>> +	u64 ack_seq;
>>> +
>>> +	if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.is_mptfo && =
msk->is_mptfo) {
>>> +		msk->can_ack =3D true;
>>> +		msk->remote_key =3D mp_opt.sndr_key;
>>> +		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>>> +		ack_seq++;
>>> +		WRITE_ONCE(msk->ack_seq, ack_seq);
>>> +		pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, =
mp_opt.sndr_key);
>>> +		atomic64_set(&msk->rcv_wnd_sent, ack_seq);
>>=20
>> It's not clear to me why the above is needed. According to the RFC we
>> should not do additional MPTCP-level key management for TFO' sake ?!?
>=20
> Addendum: instead here you likely want to setup-up a special DSS
> mapping for the TFO data. Such mapping will additionally require some
> special handling in  __mptcp_move_skb(), as 'msk->ack_seq' must not be
> incremented by the in-sequence TFO data.
>=20
> @Christoph: AFAICS, even with TFO, the initiator nor the listener =
can't
> send any other data after the syn until the MPC handshake is =
completed.
> Is that correct?

The initiator can only send data in the SYN. No subsequent packets after =
that unless the SYN/ACK has been received.

The listener can send data after the SYN/ACK. It does not yet at this =
stage know about the DATA_ACK it should use, but that is ok.


Hope I could help.

Cheers,
Christoph

