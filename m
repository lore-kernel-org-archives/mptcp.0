Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243807C
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 00:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654906173; x=1686442173;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PqvMxH13BTZN5RZ3pP9AGaVd6qjUL41/hoAFE2wN67k=;
  b=jgSo0oaaoV77+dkzpHJJ1N1vdXovhUXmysBZjPNEjoGaCE7/aVSTKugd
   cvX034gJxr1FdEOU/iZ5dK+a6brDFHRvfGzGZGqTv26sg8ZwihByNLl88
   WfxlcRgiLSjGjffd6TIkZj90SoJ9kvVcJvEWekT8/VAvpmLe8RojcwPHX
   qB0WYbwmDbsB0bzJW630wDbw/IBY5HD3YLyNAT1cAK/VN7ioXF9G4677N
   WLz+tS/hY03YLwK2MaP0rQ1bXJug8WmhgoLq4v/T5K+Oks+U+W2KaegoG
   XHnAPGNrbpn9DHlamhuhxvtFsbDKxKkc/U01Z48ZOE0KlPPU1UNOZbrtD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364115310"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="364115310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:09:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="616691702"
Received: from efbarbud-mobl1.amr.corp.intel.com (HELO csouzax-mobl2.amr.corp.intel.com) ([10.212.104.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:09:32 -0700
Date: Fri, 10 Jun 2022 17:09:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: update pm_nl_ctl usage
 header
In-Reply-To: <4894e178ac9a9ee233246a73e5c968858b7a3a87.1654839889.git.geliang.tang@suse.com>
Message-ID: <8a34aa1e-9ef5-666a-2452-786157253c@linux.intel.com>
References: <4894e178ac9a9ee233246a73e5c968858b7a3a87.1654839889.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Geliang Tang wrote:

> The usage header of pm_nl_ctl command doesn't match with the context. So
> this patch adds the missing userspace PM keywords 'ann', 'rem', 'csf',
> 'dsf', 'events' and 'listen' in it.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Appreciate the fix to the help text.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 6a2f4b981e1d..4dd87bb9ee91 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -31,7 +31,7 @@
>
> static void syntax(char *argv[])
> {
> -	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
> +	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
> 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
> 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
> 	fprintf(stderr, "\trem id <local-id> token <token>\n");
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
