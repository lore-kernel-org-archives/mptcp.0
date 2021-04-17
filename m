Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7272F83
	for <mptcp@lists.linux.dev>; Sat, 17 Apr 2021 04:24:17 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id z13so30849206lfd.9
        for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC0Ua26Rxhnd0n6CHTRnAJbktP1VUUbdUEYM+ldETTs=;
        b=oLz758tToKci7zsi0yL0Scc7eybfO9b01MpTabJVy82AvrHxAm2Q8Bl580gyU51ORl
         5O+hqfRQo/6iYzb6O/esTi7MhnB6inJ0UZ/cuMm5NCWSGF2LNtJrP8UzjS/jpcV3dYad
         niAlpUWRvdSPNLTDAVSOb0zS9baNZ+yioNktaRnNcad2e6nypv+8Y4eSUqBy996u3E+p
         dzuLhBxP2Nin+DHWvtnMYL4gfn2ujPEJkjlcfStQ5exWrdbLtmwnLwNSGW87LDnt9nVW
         0diE7nHwTIYX3X25SJy70YHdEdFqr+IDG6Fbh5R/Y3Fd7APM7uiRGoj+GA3ywBCA3jQF
         xLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC0Ua26Rxhnd0n6CHTRnAJbktP1VUUbdUEYM+ldETTs=;
        b=QIn2lXZGgUcvauimKBC2chFnKPeQm18mdt2tvfGOP6b6g9ovKfez2ixhVG4XLl06aF
         3SgNgXDIfQ3OixzDHhSEClUlrBBRE0T0JwZfGHEkqZsM1duQuojjhnqH47vKtJ8zOQLA
         Pmp/QGTiW2fRSsMJFghB+RT4hULdXa4K1rUxq8WMQHRzf2bDr3S3hspkEi+g6hwNOVJW
         KJDuIchhO7ujqArzwvvU5KO9mlHq1etjxbHFObkx5me1Vb07bP6mCsoNSd+ZBOaNWMET
         V5PsbugRp68Q0IFgv+dTWZZM8TgGnLMJ3AXo7r6KOBSF39RMAkK8M+dls9juYvM4glWx
         gddw==
X-Gm-Message-State: AOAM530jlsfpeueI0hRbhKUCIWSESpnkaQ3jgcLCC4LJXCJTfFEWv8v/
	oxqRW4LAeHeGxexFw6X8nfdB+V8GTA2dc9WgPH6x3w==
X-Google-Smtp-Source: ABdhPJzmV9SsVkwYJidvbnM4iWS8L0mm8LtiTIuV/aB/PYpvnOKcYLGWvpGibFQPijvf3rE6GcpLQP9erwMtTMvFSCo=
X-Received: by 2002:a05:6512:138e:: with SMTP id p14mr3589595lfa.47.1618633455136;
 Fri, 16 Apr 2021 21:24:15 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1618388989.git.npache@redhat.com> <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
 <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net> <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
 <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
In-Reply-To: <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
From: David Gow <davidgow@google.com>
Date: Sat, 17 Apr 2021 12:24:03 +0800
Message-ID: <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Nico Pache <npache@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brendan Higgins <brendanhiggins@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ext4@vger.kernel.org, 
	Networking <netdev@vger.kernel.org>, rafael@kernel.org, linux-m68k@lists.linux-m68k.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, "Theodore Ts'o" <tytso@mit.edu>, mathew.j.martineau@linux.intel.com, 
	davem@davemloft.net, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Matt,

> Like patch 1/6, I can apply it in MPTCP tree and send it later to
> net-next with other patches.
> Except if you guys prefer to apply it in KUnit tree and send it to
> linux-next?

Given 1/6 is going to net-next, it makes sense to send this out that
way too, then, IMHO.
The only slight concern I have is that the m68k test config patch in
the series will get split from the others, but that should resolve
itself when they pick up the last patch.

At the very least, this shouldn't cause any conflicts with anything
we're doing in the KUnit tree.

Cheers,
-- David
