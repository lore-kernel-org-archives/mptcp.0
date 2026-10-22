Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668845;
	b=e5jQxfRGWoEqHsS+l5b4hYKJB4Dq09xp0GQgrx2WrLgP+lkrOMLGISYJk8TMOsmBz0mG
	 xOu5yQ6hyPLzZMknQzmogzQOu1YNHY5JnYwX8AIAXqbSCj2fsfWSec9AIdOo6DOojl2+Y
	 X/swppTL/eyozwR7W8jmz4bsHEJQi926Sv+go/JyVMNY02uCJkXp9sYvazo3xtphGKw2C
	 UZmP0aW6BeGQ90W/dJAfsiHfN/jr1yiL/KbN5uCkg0QivPUWYk/EGxO0fZB0HTMDW1MfZ
	 wZiDUuShPO82rvC26vtom6TRADm9VIjOA/zOk8kTNjEKSkrFpQ053tndaW4/0C4EkpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668845;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/oPb7+OIDsNAVcJ2hjkcUDu5TJggJVKxdbLJnbyAdXw=;
	b=u+if6tUiW0gXv+kvZq40RRdAc9+q8f7oArWpEPnbwfVdebwCr7tp9nrWvEGP5BOP7FbQ
	 PxTd4gZbQ9foAergJuw68iUxcTzoMwaNAP6nvPZcjOOkS9ZZb0Y7IVN7mKTaiBvsfQVyd
	 uYokAqmUUpKUtVakta+Ku4q57+ncgDIncj4OU8tjTYbnQVMy9tsa07Le797qfrWraL45K
	 5KH0eO8h2bU8qtdFMD0IxQE8E+2PPEAr8G9PU+MNZ0pHQsp9velNLzlH0gBoHcLEYz2Kp
	 b0DJqx1dDnQfj+7C+sxDh+AlwpMSVcMp66CxLYRPDaEKb3uZPOTXLyiM0eJ8uc6ZSuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEVBWMqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3307606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEVBWMqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B201F000C1;
	Thu, 22 Oct 2026 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668844;
	bh=/oPb7+OIDsNAVcJ2hjkcUDu5TJggJVKxdbLJnbyAdXw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=VEVBWMqCHX86rzmmtpM1OJGSwiyYjDMDpKm458/6j7eimnkxtcWG15cxM/mUIGK3H
	 /EkfdgCeokPC13Dc/S1PfT0Gh96TYfuiO5LyPMEnSMBldQsydHrpa9NoMgfLS3E39E
	 +/kpc+rC98kq+QiAH/Cp2QfbR4b7yfRgi5o5qN4xvDcCr5W2bnbHDi6pcAWStcRCAA
	 QyHT75p/Q67JONrusSaV1Q2r3fP2NTu1Y0H70Z9z1TJaLwzoBpMlc0CFEagwUZQagB
	 RZYRQn6fP+k5hVdu8toJ7GPB/H1AvY95c3ssjk4zVIoepHwYIDPNilMsUjSY5E2I6S
	 +0fFN1zeYQugw==
Message-ID: <bb6151a5-e9b4-4b43-a57b-94aa853beaa0@kernel.org>
Date: Thu, 22 Oct 2026 13:34:01 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: echo until EOF on
 partial reads
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
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
In-Reply-To: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 17/10/2026 13:22, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> process_one_client() used a single read() and write() before waiting
> for hangup. A SOCK_STREAM read() can return a short count when the
> payload is segmented, so the server echoed only part of the data and
> then blocked on FIN.
> 
> The client keeps reading until it has the full length and only then
> closes the socket. The two sides wait on each other and the test
> hangs until SIGALRM.
> 
> Loop the server read/write until read() returns 0, and accumulate the
> copied byte counts for the existing sockopt checks.

Thank you for the fix.

> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")

Note, you can keep the Fixes tag, but target mptcp-next because I don't
think I saw the issue in our and the netdev CI, and we got asked to
delay "non-urgent" fixes like this one found by AI without user reports.
(Not that the fix is useless, but it is not urgent, and there are
already too many urgent ones ;) )

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 34 +++++++++++++----------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe..5e1ec3336859 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -638,7 +638,7 @@ static void connect_one_server(int fd, int pipefd)
>  
>  static void process_one_client(int fd, int pipefd)
>  {
> -	ssize_t ret, ret2, ret3;
> +	ssize_t ret, ret2, n, w;
>  	struct so_state s;
>  	char buf[4096];
>  
> @@ -648,23 +648,27 @@ static void process_one_client(int fd, int pipefd)
>  	ret = write(pipefd, "xmit", 4);
>  	assert(ret == 4);
>  
> -	ret = read(fd, buf, sizeof(buf));
> -	if (ret < 0)
> -		die_perror("read");
> +	ret = 0;
> +	ret2 = 0;
> +	while ((n = read(fd, buf, sizeof(buf))) > 0) {
> +		if (!ret) {

Instead of 'ret' and 'ret2', maybe clearer to use 'read' and 'written'?

(Also, with an integer, it is clearer to use > 0 or != 0)

But regarding the modification: if the 'read' is partial, will we not
have an issue with the assert below?
Do we know in advance how much we are supposed to receive? If yes, we
can retry if "0 < n < expected"?

(Note: you can maybe avoid the big loop and use a label + goto?)

> +			assert(s.mptcpi_rcv_delta <= (uint64_t)n);
>  
> -	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
> -
> -	if (s.tcpi_rcv_delta)
> -		assert(s.tcpi_rcv_delta == (uint64_t)ret);
> +			if (s.tcpi_rcv_delta)
> +				assert(s.tcpi_rcv_delta <= (uint64_t)n);
> +		}
>  
> -	ret2 = write(fd, buf, ret);
> -	if (ret2 < 0)
> -		die_perror("write");
> +		w = write(fd, buf, n);
> +		if (w < 0)
> +			die_perror("write");
> +		if (w != n)
> +			xerror("short write");

Same here: if we fail in this case, then the modification doesn't seem
useful, no?
Instead, could we try to write again? (goto)

>  
> -	/* wait for hangup */
> -	ret3 = read(fd, buf, 1);

Without the big loop, we can keep this explicit "wait for hangup" which
is perhaps clearer.

WDYT?

> -	if (ret3 != 0)
> -		xerror("expected EOF, got %lu", ret3);
> +		ret += n;
> +		ret2 += w;
> +	}
> +	if (n < 0)
> +		die_perror("read");
>  
>  	do_getsockopts(&s, fd, ret, ret2);
>  	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
> 
> ---
> base-commit: a22035be824449c4921ec406f6383089016a628c
> change-id: 20261017-fix-mptcp-issue-639-96339a3d921a
> 
> Best regards,
> --  
> Quanye Yang <quanyeyang@proton.me>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

