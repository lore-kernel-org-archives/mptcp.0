Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666187F
	for <mptcp@lists.linux.dev>; Thu,  5 Oct 2023 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4QjaW8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F18C116D3;
	Thu,  5 Oct 2023 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696499191;
	bh=tnQSjJDuvNm0C0AvLk80pFVLHlnOwed3703qOb9Vlnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m4QjaW8Zdo3DI3DgSChO8xYHpaUXwm4/7GuDg9rcgxeVd+1jwSdZR/L9jbeOqRLK7
	 AP39KTMcXkYdvs7Ojyk96dJak+NU9Tl57aDrGDVDKUODuUpmakmZJ65lwoFt1P5tUI
	 ir4AxWkNWAXcMuNi0pWbypJY+INzyU3W8YMry1aj6s/1iY/T3nJ310u1W4c/kxMq3E
	 rpNWHjzn8yssYSMjjhyBQL/J5l1dj/H34IiiJPm2t7FKiDsR3drgkNEwXia4zNFOQ2
	 S6cSt72yw6uMhlLVklImrznp6XqiYI243Scer5Njnq+b0wjN2fVPGYPkMHekowLgA6
	 Y9gFQnZeAzbRA==
Message-ID: <90e2f470-c517-4269-a280-14a02e573bf8@kernel.org>
Date: Thu, 5 Oct 2023 11:46:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 12/29] selftests: mptcp: userspace pm remove
 id 0 subflow
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <04438bad0ef7459b1a78fa88a6cd2e2c31ebf616.1695631132.git.geliang.tang@suse.com>
 <5c715ddd-f8de-4b64-8dab-4d3ad10c456e@tessares.net>
 <20231005083215.GA23632@bogon>
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
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwY4EEwEIADgWIQToy4X3aHcFem4n93r2t4JP
 QmmgcwUCZR5+DwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD2t4JPQmmgc+ixEACj
 5QmhXP+mWcO9HZjmHonVDjcn0nfdqPSVNFDrSycFg12WfrshKy79emnCcJC9I1R/DOR1rjx2
 vFPmObgGE+mmUzmF3H/FykitLLzVX7FAAbPyBRFuVYR54RJKIpV9R+u+mGYVTvNXrP0bSZkD
 6yCP2IOhXC+nm5j+i9V87f1Bb0NP1zENISIZQahY8n4bADdiaW2A3qvFBSNN+4i/oxNBmfFH
 9lylP9g9QX4WCno8E1KbwvX/vL2Q+PNDugh6dpnQiMRg/At1J+g8GE3Qc7wnCOKv6bmZfv0n
 Pj12KqIC/RAUTifdOrW5NS2q7Gcvppw/yRJOfuVv7zKcnLoyuh0cImVGptOi/hq43HNik1nm
 qamzIyJjjp9+QGtza6dMEwFbnMNbK8AngwfWwVlQ4kcJmmVg/9ee4Bd1bY9GCja7S5GQ741S
 yRu+EnmyynIFEpSHVYO5wkajFws7A0vx+3R7gsFbqoRz65sD+vLQtaSiZntNN4LBT52K1U3h
 9UxUkXEYkacbhjYH8RSfREJUoRLcFIEItRK7ZmHyFptzdBitxJOmG/adwzfkE/APKWErD1OZ
 o5N1eBeXbBJxOfUI61gwI4V+hmNjyY9ZMVmYL7glfNuQaHxphBlWsXKUVlHBprt3HCmyZk5M
 T0V8YWIYT0rFkGtfDpGRZpqfheYVNXbcjM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l5SUC
 P1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp9nWH
 Dhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM1ey4
 L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vfmjTs
 ZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbiKzn3
 kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IPQox7
 mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqfXlgw
 4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUsx6kQ
 O5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskGV+OT
 tB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIvHl7i
 qPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCrHR1F
 bMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb6p0W
 JS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxjXf7D
 2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbWvoxb
 FwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoaKrLf
 x3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6Uxej
 X+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7Ivrxx
 ySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOvmpz0
 VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0JY6d
 glzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHazlzVb
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <20231005083215.GA23632@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/10/2023 10:32, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Sep 28, 2023 at 10:58:33PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 25/09/2023 10:41, Geliang Tang wrote:
>>> This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
>>> userspace_pm_add_sf() to add a subflow, and pass initial ip address to
>>> userspace_pm_rm_sf() to remove id 0 subflow.
>>>
>>> When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
>>> false, then tcp_disconnect is invoked. This will send a MP_RST to close
>>> a subflow on the peer too.
>>
>> I don't think we should have a RST (with MP_TCPRST) when we close the
>> initial subflow, no? We don't have that when we remove subflows with
>> other IDs.
> 
> We do have a RST in "in-kernel remove id 0 subflow and address" tests,
> we can test them like this:

Thank you for having checked!

Do we have a RST if we remove another subflow than the initial one or if
we send a RM_ADDR for another id than 0? We should have the same
behaviour as with the other subflows/ID, no exception for the initial
subflow/address ID 0.

Is the RST sent by the host which received the RM_ADDR?

> 
>         # remove id 0 subflow
>         if reset "remove id 0 subflow"; then

(I think we should change the name of this test, it is confusing because
there is no 'id 0 subflow', an ID is linked to an address. Maybe:
"remove initial subflow")

>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 addr_nr_ns2=-9 speed=slow \

Just to be sure (because 'addr_nr_ns2=-9' is really not clear): it will
delete the endpoint linked to the address used by the initial subflow,
right? And this should stop the subflow (TCP FIN) and send a RM_ADDR, right?

>                         run_tests $ns1 $ns2 10.0.1.1
>                 chk_join_nr 1 1 1
>                 chk_rm_nr 1 1
> +               chk_rst_nr 1 1
>         fi
> 
>         # remove id 0 address
>         if reset "remove id 0 address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 addr_nr_ns1=-9 speed=slow \

But then here, the behaviour should be the same as the previous test,
no? Why is it not?

>                         run_tests $ns1 $ns2 10.0.1.1
>                 chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
> +               chk_rst_nr 1 1 invert
>         fi
> 
> Maybe it's OK with the RSTs.

As long as the behaviour is the same as when removing another subflow
than the initial one or sending a RM_ADDR for another ID then 0.

Cheers,
Matt
