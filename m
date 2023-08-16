Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B4168AC
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 17:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073AC433C8;
	Wed, 16 Aug 2023 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692205884;
	bh=6FuJKumKZIarDJCd2lzdWXy60mYxcI8+3yuey+psa68=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KbunZ7tCEXYJm02QBS3B5AXcizfnb8yeK9jzjdEC1qZbrrLYnpqNUW1CETSkF1xw+
	 gRa5nTcY3iVBDGHqhe/l1lu9pxFfk7Ndlag8D9W081qQ+kVQp6pBoTcpciYSrVEmXl
	 9+axaA1izQfTsNIMFLhIZDw2BLbdSfPO/moWeIj9iszOCmH3qjccbA9i7BrJWRbGbN
	 qH5+X7VWfZzZW0A77zYb5ZqclVkG4A5VMcw597cTbfYOFVOKq6frKY92gueL1x+0EK
	 7Z241dbbmfpo+AfsED6CTeFsJv4lLS7LeKLob60+XDsVw2ZBohQ3ahEUMLtpcs+Yci
	 ia5ahf5RqpZcw==
Date: Wed, 16 Aug 2023 10:11:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Alexander Witte <alexander.witte@blueflag.consulting>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: Documentation for path management plugin creation
In-Reply-To: <174ddedd-5135-4b54-9994-897cda0b6611@tessares.net>
Message-ID: <44973cc6-539a-6d55-2df0-aca7482758bd@kernel.org>
References: <F3D79FEC-8248-4710-87D1-925051CE5750@blueflag.consulting> <174ddedd-5135-4b54-9994-897cda0b6611@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Aug 2023, Matthieu Baerts wrote:

> Hi Alex,
>
> On 16/08/2023 15:11, Alexander Witte wrote:
>> Apologies if this is going to the wrong place (it probably is)
>
> You can ask general questions about mptcpd here. You can also the GitHub
> project:
>
>  https://github.com/multipath-tcp/mptcpd
>
>> I am looking to get started understanding how to develop a custom MPTCP 
>> path manager plugin for use with mptcpd.  Can anyone point me to some 
>> documentation or anywhere to get some guidance?
>
> You can probably find what you want on this page:
>
>  https://mptcpd.mptcp.dev
>
> From there, you can find links to a README (Getting Started - for mptcpd
> in general, not specific to the plugins), the wiki and the documentation
> (API).
>
> To create new plugins, a good starting point is this wiki page:
>
>  https://github.com/multipath-tcp/mptcpd/wiki/Plugins
>

Hi Alex -

In addition to Matthieu's helpful links, I did some work last year on a 
ndiffports plugin that might provide a useful template:

https://github.com/mjmartineau/mptcpd/tree/ndiffports

Compared to the in-tree plugins, the build system changes and plugin code 
are all self-contained in one commit.

- Mat
