Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11961D521
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m09Muj5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA69BC433C7;
	Tue, 19 Dec 2023 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001770;
	bh=kHw8bh8CNwj5H5w71FKycvKfCye2E9OQBeGc9tXOaHg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=m09Muj5uUGVQHg+UFFZbxPGUKSfOSJFULWkBOObN80C4vQSvnvAx9sedXlJ5P891G
	 DKCRu004Dfk2vaoPj1kkHDOS4cKBQJFbPInN3suPI3QSUIq6fnl9t5g/tYP7hHG9Lq
	 cfRgPlR6imkahuffmIYhPmQiGgLik5Axb8lazy/9a2VqkLLZpIXLsU5bUxKQIg2NTY
	 z/Mngflg8xXpaHnit0elIsaR4fhTAm0wAJe5LogDs72SX0xA3rM86rBV4+9IIkys5t
	 GhE9ruvfeYOrbPviTA6FM4+BU1nG4j5jvRyIfAw54I39f1jMf0xdNN17DLaiG209wE
	 ww+y4gsMQOxEg==
Message-ID: <fa81f7ed-694e-4491-b5c8-07749ccc2022@kernel.org>
Date: Tue, 19 Dec 2023 17:02:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 4/4] selftests: mptcp: diag: check CURRESTAB
 counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>
References: <cover.1702951288.git.geliang.tang@linux.dev>
 <6d9def0df5cb5edf499ca2538d7f5bd28721029a.1702951288.git.geliang.tang@linux.dev>
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
Cc: mptcp@lists.linux.dev
In-Reply-To: <6d9def0df5cb5edf499ca2538d7f5bd28721029a.1702951288.git.geliang.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/12/2023 03:03, Geliang Tang wrote:
> This patch adds a new helper chk_msk_cestab() to check the current
> established connections counter MIB_CURRESTAB in diag.sh. Invoke it
> to check the counter during the connection after every chk_msk_inuse().

Thank you for this v2!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 95b498efacd1..649017addb3e 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -182,6 +182,16 @@ chk_msk_inuse()
>  	__chk_nr get_msk_inuse $expected "$msg" 0
>  }
>  
> +# $1: ns, $2: cestab nr
> +chk_msk_cestab()
> +{
> +	local ns=$1

It looks like there is only one 'netns' in this selftests. I guess we
can drop this parameter and use `${ns}` directly, no?

> +	local cestab=$2
> +
> +	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
> +		 "${cestab}" "....chk ${cestab} cestab" ""

You still need to modify __chk_nr() as I mentioned in my previous
comment on the v1. If you don't, it means this test will not be skipped
(and failed) when running on an older kernel where the new counter is
not available:

  $ chk() { v="${1:-NOSKIP}"; [ "${v}" = "" ] && echo "[ skip ]";
            echo "\${v} == '${v}'"; }
  $ chk "test"
  ${v} == 'test'
  $ chk              ## <- we don't set the parameter, we don't skip: OK
  ${v} == 'NOSKIP'
  $ chk ""           ## <- not what we want: mptcp_lib_get_counter()
  ${v} == 'NOSKIP'   ##    will return nothing if there is no counter


With the modification I suggested, we will skip the test when the new
counter is not available:

  $ chk() { v="${1-NOSKIP}"; [ "${v}" = "" ] && echo "[ skip ]";
            echo "\${v} == '${v}'"; }
  $ chk "test"
  ${v} == 'test'
  $ chk              ## <- we don't set the parameter, we don't skip: OK
  ${v} == 'NOSKIP'
  $ chk ""           ## <- what we want: if there is no counter, we skip
  [ skip ]
  ${v} == ''

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
