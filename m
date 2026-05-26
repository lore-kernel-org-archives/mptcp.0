Received: from outbound.st.icloud.com (p-east2-cluster6-host4-snip4-4.eps.apple.com [57.103.76.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9553CBE78
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781970; cv=none; b=RTCOskfX2b8qYIYIetmoC7bzACMOrwIhqaz9UrGwkfYCuG0eecB7YTtGA33gag0vKm3ITH+72hbavIxfDJjqJmpZjaLWx5W5HaUk9lBXIvt5wkzY3EtEZHpSkzvg3ETYgZSfidRW+Oz7yWNgUqAY4MEFvZWCk47juObLfk7gsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781970; c=relaxed/simple;
	bh=5kfE3zLZJxdHZRY8ufUqnCcmEDuT9BLvU6/O8HRqkpc=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:Cc:To; b=lmpUreD+XH53RiukB7B0sF9KUWQey22FflPLuLi3a18a4RgQ3Ur8WvSylLQP1ObX/yUXBOTXyuTp2qGT7igio6V6jKuPzjWK/RGV0vbINtOcs3JObH7UmSO9nH1cWf4cD6yPa0aUk31+Z8LqoBJA26674hqtT+yNaWSVCh+G+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gUYLNOpi; arc=none smtp.client-ip=57.103.76.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gUYLNOpi"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id 29BEE18000BA;
	Tue, 26 May 2026 07:52:46 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhACkMFWwFeCEgDQwZeAFBcHA4OXxlbAxcfRghFGVcCVkgEVAIrWxNVF0YJGQhdHRkeV1BeCF4fTBwdDlgGEgJaRQZNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPKQJcB0V4SwNAcSl3SBRMBFUARgs2ATseKXVYB0kBOQQoc1sKMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1779781968; x=1782373968; bh=B33LzEFOGIOZ6fmveMhWRm6YRQOfoV49GCI+6pbIf5Y=; h=Content-Type:From:Mime-Version:Date:Message-Id:To:x-icloud-hme; b=gUYLNOpi+5PupIwEf26K215+v1Qu9oWufcBqbY5GFsArsNmQsBmXdiH/SWNSabWITcQ14y/B28y8v5DvJmQNxffLuzb4YSgd7kBRX4RSYXGIdvRg6JMcewrZ7T0uvyHl32ZR+17CDJ6RcPbdE4FI5v89zVLtrHD/i7eBRM3s44bzOZ+ImcN2i9qZLOm7pWDSng5SoPVj3JguYUvTApTE4w40ALsUKl7MLC1ZP+Mk7ICF6ORHolJI9s+MZMBZj9/bVGYxXrBpxzRTC7SHwVhk0d8bHPM2Ck5auqpboRsnrZeyA4DCpiegfLn7Jj8zUg/N5XFPmNgRk9WiJ/Y3uRx0WQ==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id 6D7491800BC1;
	Tue, 26 May 2026 07:52:45 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian C Guerrero <chris.guerrero0795@icloud.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Date: Tue, 26 May 2026 01:52:35 -0600
Message-Id: <D5755A30-FBE8-4787-9F8C-DB3598A7ED08@icloud.com>
Cc: Abeni Paolo <pabeni@redhat.com>, mptcp@lists.linux.dev,
 Matthieu Baerts <matttbe@kernel.org>, gang.yan@linux.dev
To: Geliang Tang <geliang@kernel.org>
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA2OCBTYWx0ZWRfXzmKeZewzZ7ua
 K4TpiPXAusXxPiruhyjUzEQyKgfFEvosco7W1HIBAoLqTTJfvYiuNiua5JLMgY6nTJfmH5EspVm
 +tYE7zUSU0TQWhPKhZLlQTUTPj+zlSqN7iDUoWbGhlflRSr7Qyeq7rnRKhBEd9PYfWF8yKX/0dh
 X16s+edmy/zexq/of9LHa7X89JtJj+rd0wOf3rdusoWWHFlP//fJ48jtyjH3iSqyT5+ZU7zuyp8
 F+wY95rDuYol0438HidmJMaV51MDUGNybewCAYdUhKnUEhkeUJFhbxfyKXePXSJHebRWBpUyuDj
 rAFmYByomdac7vNfQmWmbeqC3SuluEZASwbWYI+3JYN6tmOJUhjG1eWBHdKFQ4=
X-Proofpoint-GUID: 5tPmj6UOqj2dbtXEEkIKxlTLnVYdY4sk
X-Proofpoint-ORIG-GUID: 5tPmj6UOqj2dbtXEEkIKxlTLnVYdY4sk
X-Authority-Info-Out: v=2.4 cv=UYxciaSN c=1 sm=1 tr=0 ts=6a15514e
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=tn3to7fOw0sA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=V74gNzQc3zvTlL27lIIA:9 a=QEXdDO2ut3YA:10



> On May 26, 2026, at 12:11=E2=80=AFAM, Geliang Tang <geliang@kernel.org> wr=
ote:
>=20
> =EF=BB=BFHi Paolo,
>=20
>> On Fri, 2026-05-22 at 23:43 +0200, Paolo Abeni wrote:
>> The MPTCP output path access locklessly the MPTCP-level ack_seq
>> in multiple times, using possibly different values for the data_ack
>> in the DSS option and to compute the announced rcv wnd for the same
>> packet.
>>=20
>> Refactor the cote to avoid inconsistencies which may confuse the
>> peer. Also ensure that the MPTCP level rcv wnd is updated only when
>> the egress packet actually contains a DSS ack.
>>=20
>> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 4cc583fdc7a9..4d72f286a485 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct
>> sock *sk, struct sk_buff *skb,
>>      struct mptcp_ext *mpext;
>>      unsigned int ack_size;
>>      bool ret =3D false;
>> -    u64 ack_seq;
>> =20
>>      opts->csum_reqd =3D READ_ONCE(msk->csum_enabled);
>>      mpext =3D skb ? mptcp_get_ext(skb) : NULL;
>> @@ -601,14 +600,11 @@ static bool
>> mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>          return ret;
>>      }
>> =20
>> -    ack_seq =3D READ_ONCE(msk->ack_seq);
>>      if (READ_ONCE(msk->use_64bit_ack)) {
>>          ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
>> -        opts->ext_copy.data_ack =3D ack_seq;
>>          opts->ext_copy.ack64 =3D 1;
>>      } else {
>>          ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
>> -        opts->ext_copy.data_ack32 =3D (uint32_t)ack_seq;
>>          opts->ext_copy.ack64 =3D 0;
>>      }
>>      opts->ext_copy.use_ack =3D 1;
>> @@ -1298,19 +1294,14 @@ bool mptcp_incoming_options(struct sock *sk,
>> struct sk_buff *skb)
>>      return true;
>>  }
>> =20
>> -static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
>> +static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock
>> *tp,
>> +              struct tcphdr *th, u64 ack_seq)
>>  {
>>      const struct sock *ssk =3D (const struct sock *)tp;
>> -    struct mptcp_subflow_context *subflow;
>> -    u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
>> -    struct mptcp_sock *msk;
>> +    u64 rcv_wnd_old, rcv_wnd_new;
>>      u32 new_win;
>>      u64 win;
>> =20
>> -    subflow =3D mptcp_subflow_ctx(ssk);
>> -    msk =3D mptcp_sk(subflow->conn);
>> -
>> -    ack_seq =3D READ_ONCE(msk->ack_seq);
>>      rcv_wnd_new =3D ack_seq + tp->rcv_wnd;
>> =20
>>      rcv_wnd_old =3D atomic64_read(&msk->rcv_wnd_sent);
>> @@ -1363,7 +1354,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp,
>> struct tcphdr *th)
>> =20
>>  update_wspace:
>>      WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
>> -    subflow->rcv_wnd_sent =3D rcv_wnd_new;
>> +    return rcv_wnd_new;
>>  }
>> =20
>>  static void mptcp_track_rwin(struct tcp_sock *tp)
>> @@ -1475,13 +1466,25 @@ void mptcp_write_options(struct tcphdr *th,
>> __be32 *ptr, struct tcp_sock *tp,
>>          *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>> =20
>>          if (mpext->use_ack) {
>> +            struct mptcp_sock *msk;
>> +            u64 ack_seq;
>> +
>> +            /* DSS option is set only by
>> mptcp_established_option,
>> +             * the caller is __tcp_transmit_skb() and
>> ssk is always
>> +             * not NULL.
>> +             */
>> +            subflow =3D mptcp_subflow_ctx(ssk);
>> +            msk =3D mptcp_sk(subflow->conn);
>> +            ack_seq =3D READ_ONCE(msk->ack_seq);
>>              if (mpext->ack64) {
>> -                put_unaligned_be64(mpext->data_ack,
>> ptr);
>> +                put_unaligned_be64(ack_seq, ptr);
>>                  ptr +=3D 2;
>>              } else {
>> -                put_unaligned_be32(mpext-
>>> data_ack32, ptr);
>=20
> This patch makes data_ack and data_ack32 in struct mptcp_ext no longer
> used. Can they be removed from struct mptcp_ext, and update
> mptcp_dump_mpext() in include/trace/events/mptcp.h accordingly?
>=20
> Thanks,
> -Geliang
>=20
>> +                put_unaligned_be32(ack_seq, ptr);
>>                  ptr +=3D 1;
>>              }
>> +            subflow->rcv_wnd_sent =3D mptcp_set_rwin(msk,
>> tp, th,
>> +                                 =20
>> ack_seq);
>>          }
>> =20
>>          if (mpext->use_map) {
>> @@ -1709,9 +1712,6 @@ void mptcp_write_options(struct tcphdr *th,
>> __be32 *ptr, struct tcp_sock *tp,
>>              i +=3D 4;
>>          }
>>      }
>> -
>> -    if (tp)
>> -        mptcp_set_rwin(tp, th);
>>  }
>> =20
>>  __be32 mptcp_get_reset_option(const struct sk_buff *skb)
>=20
