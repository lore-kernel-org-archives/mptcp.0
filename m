Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE8136D
	for <mptcp@lists.linux.dev>; Sat, 25 Mar 2023 06:25:41 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pfxLD-0003qT-Gp; Sat, 25 Mar 2023 07:25:27 +0100
Message-ID: <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
Date: Sat, 25 Mar 2023 07:25:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 2/2] checkpatch: allow Closes tags with links
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1679725541;8bb7ea9a;
X-HE-SMSGID: 1pfxLD-0003qT-Gp

On 24.03.23 19:52, Matthieu Baerts wrote:
> As a follow-up of the previous patch modifying the documentation to
> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
> 
> checkpatch.pl now mentions the "Closes:" tag between brackets to express
> the fact it should be used only if it makes sense.
> 
> While at it, checkpatch.pl will not complain if the "Closes" tag is used
> with a "long" line, similar to what is done with the "Link" tag.
> 
> [...]
>  
> -# check if Reported-by: is followed by a Link:
> +# check if Reported-by: is followed by a Link: (or Closes:) tag

Small detail: why the parenthesis here? Why no simply "check if
Reported-by: is followed by a either Link: or Closes: tag". Same below...

>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_REPORTED_BY_LINK",
> -					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> -				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
> +					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");

...here, where users actually get to see this and might wonder why it's
written like that, without getting any answer.

Ciao, Thorsten
