Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337A7C6F6
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208117; cv=none; b=kaNr91BtaIHs3O4FneY0zO4sI9b2cx5YzZk7vFJqCaPp6IKqduCFIJNkBRWYwOBrZQw4CxpWYTY7QiuzR39gyrD2Mak4Xf/w7xUftAkwYq9jZ+t3Gg+nXJ7MBhufodm3WDjr6zGbTvn/PXnJCiWjKYwFa/1O22y/YU5wB/l5xaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208117; c=relaxed/simple;
	bh=pNXw8iJGE2WRpXOu8AffeyTxeJ15bH9E7iVMTQEQMuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS7Isli1TPbYu3C4rq4Y+yyObsB+Mvpp+r8UX1fIi40u6yok7C0is9VDDC/E98yEitCrBkLlZDqTxTpF/JBFXVKUXqT2XX2MAw5XPJhrUJhUuc8hUc51bq5znU062Ons/88P71RYVlYfeDFf3BZzChEROg6UFeF5ALz2jGHxXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps4LZndE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps4LZndE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88835C433C7;
	Thu, 29 Feb 2024 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709208117;
	bh=pNXw8iJGE2WRpXOu8AffeyTxeJ15bH9E7iVMTQEQMuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ps4LZndEaLOwr9Q3sOAHvdQdK/O27j2mOI2TCtmYjW4NfLIqd7m2JwFVyNN8DGVUf
	 dD2Uo0e+6oBfyMINQb8nX84ZVQOt/DDP8bGzUX81BAOQYXDZHiqzbdj5REMZlA5Yji
	 WIU5dz0KBJKM25TFWpJPfuEXo9xanOwZe9enfrpYkAady84GPgd/G3ReryLR0Gg0cw
	 JxBJ07uiKkUs/7Tem7beO5FQ1UCSNnFUMfv9pQC/Qyy8Vtcj87xljn/9gOhs+AlBxf
	 Ebf7QAy5YgmdkwvEfzJ1zsllA1MqURJAq5FUo8HWNQvC9TofvRil7dmsyPjR3wFJ2t
	 W+wgwKv7j+OFg==
Date: Thu, 29 Feb 2024 20:01:53 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 4/8] selftests: mptcp: simult_flows: fix
 misaligned output
Message-ID: <ZeByMRcqfKz1s43B@t480>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <c5534d2e878f0d776e0f46a28ba6703e0a05abd9.1709200070.git.tanggeliang@kylinos.cn>
 <ZeBXcFdtho6hZUZV@t480>
 <efe9694c-8792-4fba-a90f-44477e6909f9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe9694c-8792-4fba-a90f-44477e6909f9@kernel.org>

Hi Matt,

On Thu, Feb 29, 2024 at 11:27:29AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/02/2024 11:07, Geliang Tang wrote:
> > On Thu, Feb 29, 2024 at 05:51:07PM +0800, Geliang Tang wrote:
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> The last line in the output of simult_flows.sh misaligns with the other
> >> lines, and all lines are over maximum 75 chars per line.
> >>
> >> This patch aligns them by using the newly added print_title() helper,
> >> and truncate them within 75 chars per line to allow it to be displayed
> >> normally in regular terminals without breaking lines.
> > 
> > This part of commit log needs to be updated:
> > 
> >     This patch aligns them by reducing the number of spaces before [ OK ] to
> >     1, and truncate them within 75 chars per line to allow it to be displayed
> >     normally in regular terminals without breaking lines.
> > 
> > Thanks,
> > -Geliang
> 
> I don't know if the 2nd part of my previous comment was clear:
> 
> > But also, why not having a wider output instead? Why the 75 chars limit?

"... to allow it to be displayed normally in regular terminals (80 chars)
without breaking lines." 2 chars is reserved for "# " added at the beginning
of each line when running tests in virtme-docker. So I chose 75 chars.

> > 
> > I mean: yes, the test names should not be too long. But here, probably
> > too late to change, only modify (increase) the value in print_title(), no?

I thinks it's not too late, it's the right time to change this, since
printing title with test counter increases 3 chars for each line,
becoming much longer. It makes sense to reduce it this time.

> Why having this limit of 75 char? In other words, why not printing a
> larger title, e.g. 90 chars or more if needed?
> 
>   print_title() {
>       printf "%-90s" "${1}"
>   }

And the lines is too long already, so it makes sense to reduce it, not
increase it, right?

I thinks another option is too keep the length unchanged, not reducing
it, nor increasing it too.

WDYT?

Thanks,
-Geliang

> 
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
