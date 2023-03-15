Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B16111
	for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 19:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A97C433EF;
	Wed, 15 Mar 2023 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1678907537;
	bh=gVjMyvOh4fTj825PVq+a6hHO/8cZbwlfteXkDmUpkso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qooRDyk6bKSqHOJhCBJYQPBJNBhFH9jRPwwreHD3bywDgXEKexbdTK+Vw7c30YGdI
	 spu0DlRsH0lBvUbUzy4nzXlAQAQ2cY291e/8wY9sQQfb9cbaYMEIDCRJopbmBlnXNk
	 ASQxErPIt2V+q+q0zD2gpjA+OBZWyPr/e+IL3fJ4=
Date: Wed, 15 Mar 2023 12:12:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Kai =?ISO-8859-1?Q?Wasserb=E4ch?=
 <kai@dev.carbon-project.org>, Thorsten Leemhuis <linux@leemhuis.info>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Message-Id: <20230315121215.5e7d5d6c879e23506cb37a5c@linux-foundation.org>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
	<20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Mar 2023 18:44:56 +0100 Matthieu Baerts <matthieu.baerts@tessares.net> wrote:

> +        Closes: https://example.com/issues/1234

I (and a few others) have been using "Addresses:" on occasion.  I think
"Addresses:" is a bit more general.  And more humble - "I tried to fix
it", not "there, I fixed it".

But whatever - both are good.
