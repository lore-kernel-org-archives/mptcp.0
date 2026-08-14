Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82745A28E
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698577; cv=none; b=ZCHxCMlEiOc8L0iCtxmOGeC1cCQ+07LY6OP2zM1EoXHXCdYBpBgDr3uIjAdO5Tb0jd1JaRbrNSs/6/F1ThFnprEWjmYIBpAkxK40AKCaVNopaet0ZHB/kBQaFh0hQLjPtCwNTyoULgN5qZC1xuPsAEwEoixuN4sTfNcybv1PJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698577; c=relaxed/simple;
	bh=v7VtZtkRNB68/bdycYaJj53bIhgHAyJLcmSPZuNumq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bSyHwvOvsz89vltxhExCQ54/NCP0FBauI5RJHRfW4iwgOZma/TSwcLlU85bHlPBobEC1gaMCJs3lmmWXdftJFGHv5zRyfdvj+12tUNumk0OQLHL2cCwM/FNFphUo1guTLSevjYuSR59hNcy7bMU/R6n/GJUdvKM8POOdjnXT2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfcxcKNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfcxcKNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1591F000E9;
	Fri, 14 Aug 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698575;
	bh=v7VtZtkRNB68/bdycYaJj53bIhgHAyJLcmSPZuNumq4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=GfcxcKNr1VUx3PFrOLrfPablvhq+zZMynYBo5ASnmDbrFoS8qjskEYPpz1vhBCBrE
	 gx5tiFGc+b/RgNIyEIrk/dhDR+rqfgrlzVXCvSV2FHXMbUcOEopUwqe7V8E6lNn6y4
	 gqgBSVfFL23o8uuBnFM+9jBwOm6W6Np2e80JOKSZfAxGMO0zeTJswqZFBhrYaBASCd
	 bcFnakylMnzZzq5wPQe46Z/B/1nyDfMjoXL4b7zqrh1LP5HOMj5fXAPVqYziwiG8ZQ
	 kcdKYuu+sde17KZPUHR9ojwd2LssoDcu2BLVWB2G5dp12hULyuIwI603+MgoeMtlbx
	 lZcCK6uO+DhDw==
Date: Fri, 14 Aug 2026 11:09:30 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Message-ID: <a52da320-e6f2-4ccb-92ca-7ad28ebd49f2@kernel.org>
In-Reply-To: <643936d9-5da2-45cc-b108-f7c2e7785044@redhat.com>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev> <20260812054653.43799-3-chenguang.zhao@linux.dev> <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com> <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org> <643936d9-5da2-45cc-b108-f7c2e7785044@redhat.com>
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a52da320-e6f2-4ccb-92ca-7ad28ebd49f2@kernel.org>

Hi Paolo,

Thank you for your reply!

14 Aug 2026 10:43:41 Paolo Abeni <pabeni@redhat.com>:

>
>
> On 8/12/26 5:32 PM, Matthieu Baerts wrote:
>> Hi Paolo, Chenguang,
>>
>> On 12/08/2026 11:45, Paolo Abeni wrote:
>>> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>>>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>>
>>>> After fallback, treat the connection as not fully established so later
>>>> MP_JOIN attempts are rejected.
>>
>> @Chenguang: please first reply to the questions and comments from the
>> previous versions, then only send a new version when the discussions are
>> over.
>>
>>>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>> ---
>>>> net/mptcp/protocol.h | 5 ++++-
>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>> index 7e168e450fb0..bf2483a7ed92 100644
>>>> --- a/net/mptcp/protocol.h
>>>> +++ b/net/mptcp/protocol.h
>>>> @@ -957,8 +957,11 @@ static inline void mptcp_start_tout_timer(struct =
sock *sk)
>>>>
>>>> static inline bool mptcp_is_fully_established(struct sock *sk)
>>>> {
>>>> +=C2=A0=C2=A0 struct mptcp_sock *msk =3D mptcp_sk(sk);
>>>> +
>>>> =C2=A0=C2=A0=C2=A0 return inet_sk_state_load(sk) =3D=3D TCP_ESTABLISHE=
D &&
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 READ_ONCE(mptc=
p_sk(sk)->fully_established);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 READ_ONCE(msk-=
>fully_established) &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !test_bit(MPTC=
P_FALLBACK_DONE, &msk->flags);
>>>
>>> Does the above improve actually anything? The test is inherently racy,
>>> as lack the fallback_lock, and AFAICS all critical paths have already
>>> explicit checks under such lock, see i.e.=C2=A0 mptcp_finish_join().
>>
>> Indeed, the fallback lock is missing.
>>
>> Note: Chenguang is looking at a bug where, when an MP_FAIL is received
>> before being in fully_established, the kernel accept going to fully
>> established, and creating new subflows, then reject them once done.
>>
>> Same when receiving a 4th packet without MPTCP options.
>
> It's not clear to me what actually goes wrong and how. Do you have handy
> a event sequence or stack trace demonstrating the critical scenario?

Indeed, better with packetdrill scripts:

https://github.com/chrisocean716-star/packetdrill/blob/bf9be7a7bee368750044=
4b284a9db2a0009a5252/gtests/net/mptcp/dss/dss_drop_after_data_fallback_serv=
er.pkt

=3D> A fallback is done, a subflow can be initiated, then rejected.


https://github.com/chrisocean716-star/packetdrill/blob/fed57fab92c407eb433a=
cdb8c8ce72bd8e3e2f37/gtests/net/mptcp/mp_join/mp_join_server_after_fallback=
.pkt

=3D> The MP_FAIL is partially ignored if received before being in fully
established state.

> Both the above look like bugs in check_fully_established(), or
> incorrect/later check of fallback status/fallback_lock.
>
> i.e. AFAICS active subflows are created and added to the conn_list
> without checking the fallback status/fallback_lock, but the later join
> correctly rejects the subflow finalization, so there should any real
> problems beyond some noise.

For the fallback, it feels wrong but we could say that it's just some noise=
.

For the MP_FAIL, we should probably not ignore it in this case.

I think the MP_FAIL case should fallback. For both, the fallback should
either disable the fully established state, or the fully established
helpers should look for fallback.

Cheers,
Matt

