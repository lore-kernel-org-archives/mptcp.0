Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517CD23A6
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 09:22:32 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pcjoR-00025p-AV; Thu, 16 Mar 2023 10:22:19 +0100
Message-ID: <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
Date: Thu, 16 Mar 2023 10:22:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678958552;fe4ef07b;
X-HE-SMSGID: 1pcjoR-00025p-AV

On 15.03.23 18:44, Matthieu Baerts wrote:
> Since v6.3, checkpatch.pl now complains about the use of "Closes:" tags
> followed by a link [1]. It also complains if a "Reported-by:" tag is
> followed by a "Closes:" one [2].
> 
> As detailed in the first patch, this "Closes:" tag is used for a bit of
> time, mainly by DRM and MPTCP subsystems. It is used by some bug
> trackers to automate the closure of issues when a patch is accepted.
> 
> Because this tag is used for a bit of time by different subsystems and
> it looks like it makes sense and it is useful for them, I didn't bother
> Linus to get his permission to continue using it. If you think this is
> necessary to do that up front, please tell me and I will be happy to ask
> for his agreement.

Due to how he reacted to some "invented" tags recently, I'd think it
would be appropriate to CC him on this patchset, as he then can speak up
if he wants to (and I assume a few more mails don't bother him).

> The first patch updates the documentation to explain what is this
> "Closes:" tag and how/when to use it. The second patch modifies
> checkpatch.pl to stop complaining about it.

I liked Andrew's `have been using "Addresses:" on occasion. [...] more
humble [...]` comment.  Sadly that tag is not supported by GitLab and
GitHub. But well, "Resolves" is and also a bit more humble if you ask
me. How about using that instead? Assuming that Konstantin can work with
that tag, too, but I guess he can.

I also wonder if the texts for the documentation could be shorter.
Wouldn't something like this do?

`Instead of "Link:" feel free to use "Resolves:" with an URL instead, if
the issue was filed in a public bug tracker that will consider the issue
resolved when it noticed that tag.`

[s/Resolves/Closes/ if we stick to that]

Side note: makes we wonder if we should go "all in" here to avoid
confusion and allow "Resolves" everywhere, even for links to lore.

> [...]

Ciao, Thorsten
