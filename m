Content-Type: multipart/mixed; boundary="===============4126177567802380867=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/3] mptcp: create subflow
 for newly added address and testcases
Date: Tue, 22 Dec 2020 10:48:49 +0100
Message-ID: <6735a6c406d7126eb94268e858dea3b17ea03013.camel@redhat.com>
In-Reply-To: e619fd52-5ed1-e4bd-ca3d-d25d7f48a457@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7240

--===============4126177567802380867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-18 at 14:33 -0800, Mat Martineau wrote:
> On Fri, 18 Dec 2020, Geliang Tang wrote:
> =

> > v2:
> > - drop the unused addr parameter in mptcp_nl_add_subflow_or_signal_addr
> > - use the pernet *_max values in mptcp_pm_create_subflow_or_signal_addr
> > instead of the per-msk values.
> > =

> =

> Paolo, do you think the per-msk add_addr_signal_max and local_addr_max ar=
e =

> still needed? It's not clear to me what having pernet and per-msk copies =

> of those values will help accomplish.

Well, that was likely overdesign on my side. I thought it would be
easier and/or faster have the limit avail in each msk. It looks like
it's not really the case. I think the same consideration applies to '
local_addr_max' and 'subflows_max' so I guess we can drop all the
'pm.*max' fields.

(in a separate patch)

Thanks!

Paolo

--===============4126177567802380867==--
