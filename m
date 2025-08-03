Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79102E36EB
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754207241; cv=none; b=XGqP7vV4xPBGgFFpfc1r+Gc4rvmB7t0cDbmMpAJ+agNZ9kBJZ3p25FrkBb4cfgwS30QSc515GVJxfROpY82BIvrh2eydD/Y6V37ebuP4iUD33nCBZwvlNTEvbTOtWSBnPlqdLkS3QPaPV2ZuCYynQwY+itB6br50oONFOCXyPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754207241; c=relaxed/simple;
	bh=FK1fHmENJMIcQMasFQHmBKSnCByuVbW3kVyAb+0KzLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcxTIzLlH6JUeYkO8YWHjNFOdqCo14d6drxrNVZmcu0a+iETN69iOLVllqUZ68R6psgohX+/ejldRrxYUrDInB3iWbujaaqKNJV1v2Prn47zImPtjSWGQZSNn5LBiBCGFDsI1IKhWY63vetmPrEQgYk1sIaqWs0H0KaSGEO40eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiEMxb5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiEMxb5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FC4C4CEEB;
	Sun,  3 Aug 2025 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754207241;
	bh=FK1fHmENJMIcQMasFQHmBKSnCByuVbW3kVyAb+0KzLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiEMxb5YGHrXmEgVmnzz8VUHcOlr+yt/puvvLEjIBceBc1bttj92f+KFuUR/qFFzo
	 35z5oY3c/C4gMMepKh0fpZZy/6NO+BPdkOmI/C9tr/lzbPUZBqUr+JiH3KaKdGox8O
	 g/eNJZWiERojxwIEBmDBCDGSRq6gy7sY5J2EHZm8p3rLl7IZj5jMfgGRK9ht6gRZJR
	 k6HC4SdPqKtdmVkZZp1uBrX5SkPrAKCOjs4LAkKgGfOWIUPGpuDQVBzfEzHT9+c8CR
	 m0y/4fxqemlXcD/Huq1GeDxni4C8Uq7bqIwWSpCr1ox2w95ql4fk3W6bGNvpFlPQfR
	 KzWvfOqqyIyOg==
Message-ID: <2370b313-4d83-458a-bfe9-9b0e556e9926@kernel.org>
Date: Sun, 3 Aug 2025 09:47:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
 <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
 <0567166cba36ca9d7d0181984ae703eea7068712.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0567166cba36ca9d7d0181984ae703eea7068712.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/08/2025 08:10, Geliang Tang wrote:
> Hi Christoph,
> 
> On Sat, 2025-08-02 at 16:27 -0700, Christoph Paasch wrote:
>> On Sat, Aug 2, 2025 at 5:01 AM Geliang Tang <geliang@kernel.org>
>> wrote:
>>>
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v4:
>>>  - drop CONFIG_TCP_MD5SIG check.
>>>  - drop sk_state check.
>>>  - use WARN_ON_ONCE for __mptcp_try_fallback().
>>>
>>> v3:
>>>  - limit the use of these options for listened and closed state.
>>>  - check the return value of __mptcp_try_fallback().
>>>
>>> v2:
>>>  - trigger fallback to TCP.
>>>  - check CONFIG_TCP_MD5SIG.
>>>  - update MD5 comment.
>>>  - drop selftests, packetdrill tests will be added later.
>>>
>>> This series introduces support for TCP_MD5SIG socket options in
>>> MPTCP along
>>> with code improvements:
>>>
>>> Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
>>> consistency
>>> Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT
>>> (first
>>> subflow only)
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
>>>
>>> Geliang Tang (2):
>>>   mptcp: Handle TCP_MAXSEG getsockopt in common case
>>>   mptcp: setsockopt support for TCP_MD5SIG
>>>
>>>  net/mptcp/sockopt.c | 18 +++++++++++++-----
>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> When I run these 2 patches, I get a reset from the server :
>>
>> 23:24:48.285068 enP22p3s0f0np0 Out IP 10.221.81.117.35206 >
>> 10.221.81.118.1234: Flags [S], seq 314447609, win 64240, options
>> [nop,nop,md5 shared secret not supplied with -M, can't check -
>> bab9b1ba60e4d55efb3d475ee4222311,mss 1460,nop,nop,sackOK,nop,wscale
>> 0], length 0
>> 23:24:48.285172 enP22p3s0f0np0 In  IP 10.221.81.118.1234 >
>> 10.221.81.117.35206: Flags [R.], seq 0, ack 314447610, win 0, options
>> [nop,nop,md5 shared secret not supplied with -M, can't check -
>> c3bb41109aead9863e97f9cc4e12e7d2], length 0
>>
> 
> Yes, indeed, I got this reset too. This patch can fix it:
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 69e773059844..b22daf8c4526 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -165,7 +165,8 @@ static int subflow_check_req(struct request_sock
> *req,
>  	/* no MPTCP if MD5SIG is enabled on this socket or we may run
> out of
>  	 * TCP option space.
>  	 */
> -	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
> +	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info) &&
> +	    !__mptcp_check_fallback(mptcp_sk(listener->conn))) {

If __mptcp_check_fallback() is true, does it mean we will accept
SYN+MPC+MD5?

Should we not have something like that?

  if (__mptcp_check_fallback())
      return 0;

Please provide packetdrill tests: for the client and server side. For
the server side, with and without MPTCP in the injected SYN.

(+ adapt the one causing issues)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

