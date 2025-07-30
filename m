Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B92236EE
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913034; cv=none; b=r8mFeiuP6mRqOi/YGdt/AIk7TZZlIhlpcSdphq0tJ5+tmJbElW9LYjMW6mTkHJMAG4Wjd5lbU7T53XHUn9DAC2pxdZ/lS+8G9dmYIQ2C8QOyWfv176NKODBfVNp+f+D5AOYtWrko8h+7epEx52dHfzmg9vCskTC5CbLLHPiTxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913034; c=relaxed/simple;
	bh=WQnIdrez9sN48UxvjVPcxFXhDLQivik1ZyJhs9D63ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5/uBok/rdCnxGGUkvge7CnDzdeu8XlZUrXb6nACDWGghtgo3uBOtXFG7ZX754xMCnNyckUvG+32gRrcpzs1B/b8ZS7A/N18tJyOtFBy8yHsHKUfvldAhnGTEr7nWM81+LmsBUddu0hEcfCGm0gpiNPXaGHqBzxeBl2fbttsSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhUdBYIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhUdBYIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A825C4CEE3;
	Wed, 30 Jul 2025 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753913034;
	bh=WQnIdrez9sN48UxvjVPcxFXhDLQivik1ZyJhs9D63ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uhUdBYItKaoD1tx/fJRFaUzyPH8jWc8QW9QIg6O/l8dLbqHN/J3Ad1OBy8MvGsTS1
	 NOuTDn5b2XCsqoBK34wyXW3q0Inws7Ycoi+JMWD54iLmMiq3qbx+ecBXoJIc6PMaGi
	 Km3DQo8iY0LnsGrHCSGyDjPVUTJWAWt3+sD5Xc2egT19F3WS72Z4skeVj/m7eMsHO+
	 pCvn+fhX6HaLiiSrCUTN3ImCCaa+5Bz1FgHxsw5OOHU2NLh6cQEzMpJLEXVbzV++XT
	 qFUjjkS5G4Nsnf9s0FJzjhvDDaINJ/zNkkvz8yFgiYxkY/961uKfLh2iAK4kI1nC0e
	 WgoXynG8K9lKg==
Message-ID: <4fe3f272-4ce0-4ae3-9f59-02bcaf6231de@kernel.org>
Date: Thu, 31 Jul 2025 00:03:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/7] Add MPTCP support for socket creation
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <cover.1753247666.git.geliang@kernel.org>
 <d97fe07c2fb587f1672bcfa73524daab035ed61c.1753247666.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d97fe07c2fb587f1672bcfa73524daab035ed61c.1753247666.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/07/2025 07:16, Geliang Tang wrote:
> This patch extends the socket creation functionality to support Multipath
> TCP (MPTCP) by adding a new 'mptcp' parameter to the native socket0 method.
> When enabled, the socket will be created with the IPPROTO_MPTCP protocol
> for stream sockets.
> 
> The changes include:
> 1. Added the 'mptcp' parameter to socket0 method declarations in Net.java
> 2. Modified the native implementations in both Unix and Windows Net.c files
>    to handle the new parameter and set the appropriate protocol
> 3. Updated all call sites to pass 'false' for the new parameter to maintain
>    existing behavior (MPTCP disabled by default)
> 
> Co-Developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>  src/java.base/share/classes/sun/nio/ch/Net.java | 6 +++---
>  src/java.base/unix/native/libnio/ch/Net.c       | 5 +++--
>  src/java.base/windows/native/libnio/ch/Net.c    | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
> index 9ec7975a35c..c086429380b 100644
> --- a/src/java.base/share/classes/sun/nio/ch/Net.java
> +++ b/src/java.base/share/classes/sun/nio/ch/Net.java
> @@ -488,7 +488,7 @@ static FileDescriptor socket() throws IOException {
>      static FileDescriptor socket(ProtocolFamily family, boolean stream) throws IOException {
>          boolean preferIPv6 = isIPv6Available() &&
>              (family != StandardProtocolFamily.INET);
> -        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK));
> +        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK, false));
>      }
>  
>      static FileDescriptor serverSocket() {
> @@ -498,12 +498,12 @@ static FileDescriptor serverSocket() {
>      static FileDescriptor serverSocket(ProtocolFamily family) {
>          boolean preferIPv6 = isIPv6Available() &&
>              (family != StandardProtocolFamily.INET);
> -        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK));
> +        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, false));
>      }
>  
>      // Due to oddities SO_REUSEADDR on Windows reuse is ignored
>      private static native int socket0(boolean preferIPv6, boolean stream, boolean reuse,
> -                                      boolean fastLoopback);
> +                                      boolean fastLoopback, boolean mptcp);
>  
>      public static void bind(FileDescriptor fd, InetAddress addr, int port)
>          throws IOException
> diff --git a/src/java.base/unix/native/libnio/ch/Net.c b/src/java.base/unix/native/libnio/ch/Net.c
> index 28c1814f422..1b08539873f 100644
> --- a/src/java.base/unix/native/libnio/ch/Net.c
> +++ b/src/java.base/unix/native/libnio/ch/Net.c
> @@ -255,13 +255,14 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
>  
>  JNIEXPORT jint JNICALL
>  Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
> -                            jboolean stream, jboolean reuse, jboolean ignored)
> +                            jboolean stream, jboolean reuse, jboolean ignored, jboolean mptcp)

(I don't know if there is a limit for the number of chars per lines,
maybe you need to go to the next line?)

>  {
>      int fd;
>      int type = (stream ? SOCK_STREAM : SOCK_DGRAM);
>      int domain = (ipv6_available() && preferIPv6) ? AF_INET6 : AF_INET;
> +    int protocol = (stream && mptcp) ? IPPROTO_MPTCP : 0;

I guess you will still need to check if IPPROTO_MPTCP is defined for old
systems, or the ones not using Linux. Something like that:

    int protocol =
#ifdef IPPROTO_MPTCP
                   (stream && mptcp) ? IPPROTO_MPTCP :
#endif
                   0;

(or another style, I don't know what is usually being used here.)

>  
> -    fd = socket(domain, type, 0);
> +    fd = socket(domain, type, protocol);
>      if (fd < 0) {
>          return handleSocketError(env, errno);
>      }
> diff --git a/src/java.base/windows/native/libnio/ch/Net.c b/src/java.base/windows/native/libnio/ch/Net.c
> index 814f502c48a..c563aa9f031 100644
> --- a/src/java.base/windows/native/libnio/ch/Net.c
> +++ b/src/java.base/windows/native/libnio/ch/Net.c
> @@ -152,7 +152,7 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
>  
>  JNIEXPORT jint JNICALL
>  Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
> -                            jboolean stream, jboolean reuse, jboolean fastLoopback)
> +                            jboolean stream, jboolean reuse, jboolean fastLoopback, jboolean mptcp)
>  {
>      SOCKET s;
>      int domain = (preferIPv6) ? AF_INET6 : AF_INET;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

