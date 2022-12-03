Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB57B;
	Sat,  3 Dec 2022 08:29:36 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id u12so10304273wrr.11;
        Sat, 03 Dec 2022 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++FsqaVqwJx6XYFbJqgrWmLCuJt14qXZ43q8ET3YWf4=;
        b=HhfB9e8o57PE+BDcjO4D+jMa9L2vT2zeY2txxBD+V5LKRTWgFJVzBkl5jHWXj1bCDW
         QVKgDv85lfi2w043G+9Gi25eC0dyUzBLrL5JPfHyfU+e/1pfMR1WONQke/2Q6IraVpLc
         2s9FHnav4wzkVHIdgCN1COw8oCcN2D+05RgdcXi3Nub2a1K9zM9XGoyU/75s7nLCuVJK
         G9nxsa6POuXVHIIRB60+QGpjDv2jxAu7+zDi5qy8y0YIvxQHyphjhC9VKVhabDEybyCo
         lSqFFem87i7NJ9CMH2uRp35qLFqHGYruXb2F2AiVcgdFOW9Q1fgBAO+5VXaGhpNprclJ
         ghLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++FsqaVqwJx6XYFbJqgrWmLCuJt14qXZ43q8ET3YWf4=;
        b=HX4gk2jrWJcf0/1tvZoprUf7yqOpTm+DFUNFrdBXEmmumMWvMpXkybE5kSzAc4DpH2
         x3rQgfTRv6QH+Xe2BA3r9OB4ydD+vw35yU9w6yJp1T/XYjevBCp8eKKIWxv6VpM8ko8Y
         N3XYh0qphMtap6hyAStL96TZFIOlWXXtqn/eWWCwcX1NaQ1fSXRFI2uMNeQVL7TAKAC0
         S1cwa44SpVFk8HBO2bnb23pDK0lJ13dCxvsp13uSh3EN1UaoqQ4LS9/OOvGdhUJqPDd1
         45F8PzbzFPVq4+W59QM/BvI4FiFqVLOJ2kuxKkOw7P/3odLpdYcjB//+9r6iGpP4XnUT
         GtnQ==
X-Gm-Message-State: ANoB5pnUuCEIMluxJFmbJa6N+xzWgwjzb6m7W5x9ii4M/CJ6X4inOYJz
	TSI1kgDpDA9v3y3NR/W+v7g=
X-Google-Smtp-Source: AA0mqf5psme3doI+eE0Qu5GiQ8w8heQyM/BTczlkyI/94oO5q37sIh7C9m/7yqsfMCCRQxuohNF6mA==
X-Received: by 2002:adf:ea4e:0:b0:242:1d48:e043 with SMTP id j14-20020adfea4e000000b002421d48e043mr15623224wrn.498.1670056174834;
        Sat, 03 Dec 2022 00:29:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b00241fab5a296sm9025238wrp.40.2022.12.03.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:29:34 -0800 (PST)
Date: Sat, 3 Dec 2022 11:29:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, lkp@intel.com
Cc: oe-kbuild@lists.linux.dev, Florian Westphal <fw@strlen.de>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn:
 missing error code? 'err'
Message-ID: <Y4sI65oadrVtBlnR@kadam>
References: <202212021422.Uh5cCKY2-lkp@intel.com>
 <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>

On Fri, Dec 02, 2022 at 03:38:01PM -0800, Mat Martineau wrote:
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1158  	/* no validation needed - was already done via nested policy */
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1159  	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1160  					  mptcp_pm_addr_policy, info->extack);
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1161  	if (err)
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1162  		return err;
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1163
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1164  	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1165  		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1166
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1167  	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1168  		if (!require_family)
> > 982f17ba1a2534 Florian Westphal 2022-05-03 @1169  			return err;
> > 
> > "err" is zero at this point.  Presumably a negative error code was
> > intended.
> 
> Hi Dan -
> 
> The intended error code is 0 here: the return happens if no
> MPTCP_PM_ADDR_ATTR_FAMILY value is present and require_family is false.
> 
> It would be clearer to "return 0;", but the code is working as expected.
> 
> 
> Could you be sure to cc mptcp@lists.linux.dev and
> matthieu.baerts@tessares.net for future MPTCP issues?

These emails are automatically generated by the kbuild team.  I don't
know what kind of heuristics they use...  I've put them on the To
header.  There is probably a reason why they don't just use
get_maintainer.pl...

regards,
dan carpenter

