Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28033CD
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 16:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665506105; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AuNiCCDmJ63CVTBAbSrCSSuiHSHMLlVJEPePpmVq02vZfTVqFJBjreTjKX804HkpN0oV+2kcJx6qO2pZ0d3oyCZskE52CqT4nEsib8U5xPodLQlkGhznWfoyK1MIgULcT3HNoKbYk2NB76nn1xKj7IpXWX/slgep6afrsVqZU34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665506105; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=UzSgWTQfaLuymuYlg3VudYUydCQ00n5NwMRB8F+1g6M=; 
	b=Dvd2Ik+0LcItFUzFX0KAFDk21s0+08NLri19LuxW81fjLm2MNT+uBv+x17p7NZfUZNLXwe5e9Oyefg76aqzpdHHjkWmcTNmESSVpJ9wcXn3by7a+xB/eblFyX8MbXLHOo7n6EYKtbqYHwraF2qQr+ybNu3W3Hpx+0CvxArbvORU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665506105;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UzSgWTQfaLuymuYlg3VudYUydCQ00n5NwMRB8F+1g6M=;
	b=IK9dbnTUK8Bzwdw1gh8ULCLfrDML4dtUtmMeT+1UPVuVmnufmw7HiAwDD4NsstG3
	wLkeOBi0IZLGTRAnrpHKrY32/kTTxJipveR+q2mPsUShDVu0dGC17O4Sk8n5CL2QxF2
	h9QDeAbeeqB59KbrxRuIirHC6CBX9XiYCnH2AjwU=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665506103795500.5700941382554; Tue, 11 Oct 2022 18:35:03 +0200 (CEST)
Message-ID: <374bf0f9-c7d7-b658-c92a-816b154c69b7@shytyi.net>
Date: Tue, 11 Oct 2022 18:35:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20221010221809.1792-1-dmytro@shytyi.net>
 <20221010221809.1792-6-dmytro@shytyi.net>
 <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
 <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi!

On 10/11/2022 5:49 PM, Matthieu Baerts wrote:
> Hi Paolo, Dmytro,
>
> On 11/10/2022 17:33, Paolo Abeni wrote:
>> On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
>>> This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
>>> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
>>> We call sendto() instead of connect().
>>>
>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> (...)
>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> index 621af6895f4d..d2328f94d1df 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> @@ -677,6 +677,58 @@ run_tests()
>>>   	run_tests_lo $1 $2 $3 0
>>>   }
>> I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?
> We only need to test with one subflow. Then mptcp_connect.sh should be
> fine, no?
>
> I know Dmytro likes to duplicate code ( :) ) but I think run_tests_lo()
> should be re-used. In this case, we reduce the modification to a few
> lines (e.g. what is done in run_tests_peekmode()).

I also prefer avoid duplicode code ( :) ) in the resulting solution.
I didn't notice run_tests_peekmode(). It is a better way!

> Then if we limit the validation to 2 tests: one in v4 and one in v6
> (between two fixed ns, could even be the same ns ), we are OK, no? More
> complex stuff can be added using packetdrill. WDYT?

Ok for me. I'm changing the selftest (*.sh) to act as in 
run_tests_peekmode().

Thanks Matthieu.

>
> Cheers,
> Matt
