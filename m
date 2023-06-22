Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0463A4;
	Thu, 22 Jun 2023 07:53:17 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qCF7z-0000Bw-Gm; Thu, 22 Jun 2023 09:53:15 +0200
Message-ID: <163df4ec-089d-4bff-c613-dd8a0c3b2110@leemhuis.info>
Date: Thu, 22 Jun 2023 09:53:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-US, de-DE
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: evanhensbergen@icloud.com, MPTCP Upstream <mptcp@lists.linux.dev>,
 v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
 <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
 <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info>
 <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
 <0dd7af94-db5f-ab39-dc79-285de4bf0a11@tessares.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <0dd7af94-db5f-ab39-dc79-285de4bf0a11@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687420397;312f80d0;
X-HE-SMSGID: 1qCF7z-0000Bw-Gm

On 13.06.23 18:27, Matthieu Baerts wrote:
> On 13/06/2023 18:07, Eric Van Hensbergen wrote:
>> Understood, this on top of my 9p stack, but day job has been getting
>> in the way lately so I need to unstack there first.  Will do my best
>> to reproduce and understand as quickly as I can -- but given its a
>> performance regression it is likely going to be tricky to reproduce
>> and understand, so I'm not sure how confident I am that we'll be able
>> to close it out prior to the final -rc.
> 
> Thank you for your message, I understand, no issue.
> [...]

As Linus will likely release 6.4 on this or the following Sunday a quick
status inquiry so I can brief him appropriately: is there any hope the
regression will be resolved any time soon? Doesn't look like it from
this thread, but maybe I missed something.

> (but I don't know what's the impact for other people of course)

Yeah, it's likely not that urgent, if the problem is just showing up in
some CI tests. But is that what we assume for now? Eric?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
