Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF771
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 04:03:37 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id p17so10160941plf.12
        for <mptcp@lists.linux.dev>; Mon, 10 May 2021 21:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bhiHq09+VkaSxgFey/8cp/PqrXrwaaqzhxJ2U/UhvCk=;
        b=Mddo7N78+UsfaknrW7c7U4W9BJkvk2GSALnvxYJJkVHMdqKPEw07QKPkoOl7lytH5t
         z7lt+/oRvBU4DALbqBNV/9PCt+Xl3yPQ5O2PnA7GYtdQN9cazYc5mjRZ40ffTWK+x/Gy
         mZHQkt2+SjulCBg7b0BwzAvreNHroEuBZ08wXALdCYETY2lCbx4HVw1y0D6BWOm4o6xi
         ppd0eUUdPLOgwNCuhfu7T+J3mvEtOz2uoDx+41X1fRmLr/1cJlhjNd91jMC8/9lKCYuE
         WzNyBUC5hIJ1qZU0LxeCHsbhXWkTZutccyeQsP/v26cXy6SNu+xoQDw406g8gJ6K3Pkn
         krng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bhiHq09+VkaSxgFey/8cp/PqrXrwaaqzhxJ2U/UhvCk=;
        b=p5FFppHVPF8sS1pKZfI9CGi+14Q+ZQYYM8xXPVKzzWe3GNNWuaJrd1ONdflcAlUX0U
         2OH+DHei52rb4oVyJKdJY7jrusGRZ8blQGeWbEsklAa1rZgvSvFuS3NaYSEdwrR74uZA
         STEBEwIL0OpTD3dqJshBZY3DqtXhhvfaib8p57l3GKWQZdUkG1L73cyAxbm7cWXMXJ+E
         J4Z21iWiHOUEt9IEyFrpQLTIOjGYTSotuChwB+tdKdW3VbMbepilllh3v+7rlC663Qs8
         bsYTqhIoVGbYoIdfsV3SVNaYtKwblsWSz7A6Vl7pchh+3aymUrRDeJMLCRrAWblraoHR
         bHpQ==
X-Gm-Message-State: AOAM533zgpTY799LTDHLQ5ZBZ/qJUXu7lVVx7jhBQpBLXdR5bY8bn7l5
	GwTfftHf8l4uwootvH+9kXs=
X-Google-Smtp-Source: ABdhPJxjD+kJQTUappMc/Y59Lvi++/A3dG+zyCow3/CogZaLsPF1Z3kdYwdIhb5fgG/DV5DBg+VAkw==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id o11mr32337932pjq.159.1620705817299;
        Mon, 10 May 2021 21:03:37 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x11sm12664027pjr.21.2021.05.10.21.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:03:37 -0700 (PDT)
Date: Tue, 11 May 2021 12:03:34 +0800
From: Geliang Tang <geliangtang@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
Message-ID: <YJoCFsHJjFSPgE4G@MiBook>
References: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
 <e3d8cbf6-4de3-40da-5442-49d5265f9f5@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d8cbf6-4de3-40da-5442-49d5265f9f5@linux.intel.com>

Hi Mat,

On Mon, May 10, 2021 at 05:45:48PM -0700, Mat Martineau wrote:
> On Fri, 7 May 2021, Geliang Tang wrote:
> 
> > Move the csum_replace2 trunk into the later patch "mptcp: receive
> > checksum for MP_CAPABLE with data".
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > net/mptcp/options.c | 3 ---
> > 1 file changed, 3 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index beac01f58cba..99fc21406168 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -519,9 +519,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> > 		 */
> > 		ext->data_fin = 1;
> > 		ext->data_len++;
> > -
> > -		/* the pseudo header has changed, update the csum accordingly */
> > -		csum_replace2(&ext->csum, htons(ext->data_len - 1), htons(ext->data_len));
> 
> The commit message above says this is is moved to another patch, but the
> posted squash-to patch for "mptcp: receive checksum for MP_CAPABLE with
> data" doesn't add this functionality back. Is a hunk or another squash-to
> patch missing?

Sorry, I didn't describe it clearly.

No squash-to patch is missing here, this truck will be moved to another
patch automatically when resolving the conflict.

Apply this squash-to patch (Squash to "mptcp: generate the data checksum")
and rebase, we will get a conflict with "mptcp: receive checksum for
MP_CAPABLE with data":

$ git rebase --continue
Auto-merging net/mptcp/protocol.h
Auto-merging net/mptcp/options.c
CONFLICT (content): Merge conflict in net/mptcp/options.c
error: could not apply d56805c0f705... mptcp: receive checksum for MP_CAPABLE with data

Resolve this conflict like this:

'''
<<<<<<< HEAD
=======

                /* the pseudo header has changed, update the csum accordingly */
                if (ext->csum_reqd)
                        csum_replace2(&ext->csum, htons(ext->data_len - 1),
                                      htons(ext->data_len));
>>>>>>> d56805c0f705... mptcp: receive checksum for MP_CAPABLE with data
        }
}
'''

 ->

'''

                /* the pseudo header has changed, update the csum accordingly */
                if (ext->csum_reqd)
                        csum_replace2(&ext->csum, htons(ext->data_len - 1),
                                      htons(ext->data_len));
        }
}
'''

Then the csum_replace2 trunk have been moved to the patch "mptcp: receive
checksum for MP_CAPABLE with data" automatically.

Thanks.

-Geliang

> 
> 
> Thanks,
> 
> --
> Mat Martineau
> Intel
