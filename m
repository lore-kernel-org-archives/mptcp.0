Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EC1B9E
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644974247; x=1676510247;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GXveSrJ8TX89kx50zW9ddZ7OftnGoo/egUAP7zHTh8A=;
  b=LD6RjfM8HVdbER7bDfxj4vbp4NmizTOAj1NIkyDt3x7u/Y2+CtlK6d6b
   qrOVIKsg10AkwuJu81DxecFZRWu0DxjPbUFd9CxuR2Siz1dwYlnWDjh1Z
   jGpOPyCL+EkgedQihvBh+UzOxd6lvgK7EjqnP8yVX/yZNfJXfqPvZA+ni
   nSui06j+JBgzsEjckRqjZIlaD/EAKp1Zawy9I0uHmYIu6gj6s1l5Hg7qb
   jp6zJdzUGPLprgxEaaYtT7uaaz3IIRPN8x3IL7MRFajqgzlttQ3srrb2f
   5iHbIX31CQ7qj23ew4OuN7DBZltFDUh6IrKIX9w1+mEDhHNiBrDMW9OyO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250440193"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="tgz'50?pcap'50?scan'50,208,49,50";a="250440193"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:17:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="tgz'50?pcap'50?scan'50,208,49,50";a="571075327"
Received: from skling-mobl1.amr.corp.intel.com ([10.212.200.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:17:17 -0800
Date: Tue, 15 Feb 2022 17:17:16 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/7] add fastclose testcases
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
Message-ID: <4267dfb9-224b-228a-83c0-6d2da77fd8e1@linux.intel.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-703175191-1644974237=:18794"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-703175191-1644974237=:18794
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 15 Feb 2022, Geliang Tang wrote:

> v3:
> - merge the squash-to patch ("Squash to "selftests: mptcp: add
> fastclose testcases v2") into v3.
> - add a new patch to check fastclose in mptcp_connect.sh
>
> base-commit: 9dff76d953f7a0fe2b27818f2aa93031c9a617cf
>
> v2:
> - merge the squash-to patch ("Squash to "selftests: mptcp: add the
> MP_RST mibs check") into v2.
> - update the commit logs.
>
> This patchset is related to issue #48 and issue #197. The two MP_RST
> patches are moved from the "add mp_fail testcases" series.
>

Hi Geliang -

The code changes and the squash-to patch look good in terms of code 
review. When I run the 'mptcp_join.sh -z' test I get intermittent failures 
with "fastclose test 2":

002 fastclose test 2                     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          ctx[ ok ] - fclzrx[fail] got 1 MP_FASTCLOSE[s] RX expected 2
                                          rtx[ ok ] - rstrx [fail] got 1 MP_RST[s] RX expected 2   invert

(removed MIB dump)

I was able to reproduce while capturing, and the capture in the failed 
test does have 2 MP_FASTCLOSE and 2 MP_RST. Maybe there's a timing issue 
reading the MIBs?

I attached the pcaps, one for passing and one for failing.

-Mat


> Geliang Tang (7):
>  mptcp: add the mibs for MP_FASTCLOSE
>  selftests: mptcp: add the MP_FASTCLOSE mibs check
>  mptcp: add the mibs for MP_RST
>  selftests: mptcp: add the MP_RST mibs check
>  selftests: mptcp: add extra_args in do_transfer
>  selftests: mptcp: add fastclose testcases
>  selftests: mptcp: fastclose check in mptcp_connect
>
> net/mptcp/mib.c                               |   4 +
> net/mptcp/mib.h                               |   4 +
> net/mptcp/options.c                           |   5 +
> .../selftests/net/mptcp/mptcp_connect.sh      |  37 +++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++--
> 5 files changed, 171 insertions(+), 13 deletions(-)
>
> -- 
> 2.34.1

--
Mat Martineau
Intel
--0-703175191-1644974237=:18794
Content-Type: application/octet-stream; name=fclzrx-pcaps.tgz
Content-Transfer-Encoding: BASE64
Content-ID: <a8518b20-d1bc-3669-8a24-2dffec6f66cb@linux.intel.com>
Content-Description: 
Content-Disposition: attachment; filename=fclzrx-pcaps.tgz

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
n6eO4uHQ6TV4rz/PHBjefv6POKQuxHIgrPHLyQ+8HNB+Y1X4/eTY57/C4XEj
lgNhjR+H3nKS2Pm2tNoU1AeIV4awKtBzKdkHDportbYQv+8hIn2m8NmBKsBq
kOGZrcnrryAs4pUhrJtBVKzX4fdbW4jf9xC5fnrQoIfGgOVfzDMTpNPzPEoU
Px+B2XNIP3pVjm5tIf6FP4c+rlgOf9NzfMR5ZhPwcqDsO/PhIBrMKr2MDIu0
vRNsh078v/dvFu9c007vJft5ZzRg12ukDoYc49YW4l/4c1jzEsvhb9ZrlV94
ZjTwcqDEmQ8HIs5d0N63iEjbO8G2uSfPjIZO/dw6QHCQ12NhZ2+SuUbO3mz7
GZ6W2wzAMzO8fzv2/R39npy92faz1M88B0vw/iH6+O8mSXzYx8tApw/YN38+
qy/U7K0QFoKexXn38byikYPt+3iAkavPwu7jkRz57OMtfKad50PgiPPu443f
AzjkPl6Oz1DfsnNjVAFL2wCHRfNnagb6Np99ieGPOIG3jr6P5xUDWLCP9yBx
T9rKa+/yqFgPDFnYyZYUrIAM9L0uOwyHRZ9s2Y6lwIsFpzYkVd3F02QGai50
KGzV2NUj8FyexDVZTo7oZ877Egf9/Bvff7M7oL+g+4K/FJw897f0t1wmBgw/
YRnSlA8YYQ0MuRoM5dcBS/p0UKR6DEwHzarc9XEkW9dj+eiy8xBsNJdCJcbV
a4Ph+lrvge6WG1RWyYw473Iuf47DlRDbIX11Z6zwczf61hzd10uOW5R+TSHZ
cexBYJgyVoj8Q9/nsq8zNNQnWGbQvxtv11BaXaydXS1glGExaCpMHGGDVFjC
UCEDcOjf37arQGC0GgRNz6rcPQAw9iXyPNti+zXzeZF/L3H5ju0lfPo1cHBL
4jlLxcuB0iv5cCB65QdHZFik7Z1gO3o//m9VMNeVzOd//v6tfYX1j8+6Ejio
p+DPitE4UPzjw4HwT96kzb+2d4LtDdPxp7AoeRiUgb4HZgfj8pB+Cst7EcpD
RfWeZB6SucJqn9qZa2Z7Omzl7KOzU3b2Cpp//nxz2jP5M2WPLNLn9y0b6vNU
c0x2nmmx9Ki6lp0n97zTl1+umQ8sU7EsaZkcNMIWZbIaLpPpJ9pMlqJMJliS
7Ei2JMv4qojnthl3JXdPTBohb3xmm/juVX0n17TM3rQjYfY3jdF22VKayqKN
fyXFbNrjrNtT/fbc78BSbSb+uyFaTX9EWhYxtHQlmJbSaxq0NFnaUdPl6oDx
A4vBqOm5SAknhhKlgEOvaZNlgEOpaRvA4Mbz/G0U7FqbuS/DP+ejBmJzns9a
G2mZwHO+gpcDJef5cCBy/hW3Lefb3nkAfTeNP/FPy/k6FCcOLk70nPcZDDp2
5Hy5Oqklq31aZX3WVa7DU+OR5xfel3uy1qbf6TGLtUvDT5TX7tdcrbu6Li3v
00PW+M2HFmQX9k7tPiqtRGsFsHxkjz8FQou0HYq0IybSe+iRnjAcmFIiHQwY
Uo74Gxq0ukJTtLnKOAx6XU3QRhgddRVMKkIqYddlS8BRz4axWvILCuM0kj50
s1Oap202TqViWsERxX2u3v7B88wHJdslpnAPWltriM/48hFYxjrhz33Q6qoe
xesKI157nmnnS9PrykcDmFLqyhow7Jbz/H2cTl3zo8+aLTwcsOty5t4cfw6r
jmI5/M26PH+rBPYMIo0Dpe74cCDqbk0iMizS9k6wbT5BuL2q/7Kv6K/B3x6h
1X4DyqVAXC4xar8W5VJH7VuTmc9qn/YYd8xHbU4t+/elnKc7L/U0vDur+7HT
RjpL1nfJGb/VefDU15Ia+rkPy6tS19sNPng34NHx12uBpaE7/vYIrfbRZHbu
7/S6zJcmmN5i1D4XmFJqPw8w3nvgb/vQah9NFecq4jAYtd+G0VH7eaQipBKR
CTX2vu+vHxqY5126pUr7wgvps3WKNzburjoyv1784xC3KSXVWdc4KTZNcrLN
20cWNC6LB5YGa/F/14i518zcp+KfMzZHsDnDZ68ZOCxei4sGo/80Yp+tbhFq
mTD6D+QMl9J/tgCGjjfu7C/DT0rd8fGTqLvk9vOEbe8E276rcPN0efclmftv
/DXc4YbVkM++JHDYu0YKexaTxoHiHx8O8Hmu1OZf2zvB9jnemTmdum+F1mXq
PHtnnZ6nuxxx+3ed+6yitQk/v7Uzc21KEP5eHK2zoRn/3P6MzmbC29kmXuTT
2baw2idTdpfa5bb7tmRy4vbNQaqT5b4c1r3Vx0OLXayywECqjtOofdBL7omd
ZoSYbOkjvZ6xFXGqaBdlAZYl45PoE+oqm3Bdhf5JtC4PdZWOT6ItJFuS5TCp
m90K5FLuWaqlGczLXOxvrxJu6T1GMqTnYrdbCdq+3ebZtcreTVqU7ZNyOdIu
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
+aWbXjuF26gl9pl9qqvzY2C5PUfweiMT3fNk5zC0LCCYjmbEqwSYUuLlCxgH
jwheb2Siu53slTgMerwCYhBGR7x8SUXICX+9EpqGNmpWftLapjHb23hupF2q
xb7myIODZynPP1G99diih5u8Fw1QTY40XKOXccjf1GWeMqqvi0KsN9D0c64M
I16jCaYN9HhNTQamlHiVkWxJlu+czZ502VviMFHBaFVM9JuwZ0svXV+0t/hO
jMP5vFfxPUclO8eJ/VkdNsfe6XV1RUO6lfF3YCl5SfB6IxPdM2VnM7RsIJgu
o8crYBcwpcTr8EECY8UGIdYb6K4p2w2HQY/XpkUIoyNeh0lFyAl/U10njIi5
lW8hO8lzoeN67UFKYaqe/f+nvTOPqjGN4/gtu67lWpKtQgtKZSJbYysVyjHh
ukxKZ2wZS27jYDJa6dZVWg4lV5YpTSVMjrLMoRmpRI69TJYUkyUi5iIZ8/4e
93Xf5+2Zue+M/Pf8/naez/e3vI+H+z7fN8Z3Xp6nY3JVH/N4RxfZrSrXyZUx
CSkm7bpslBisBZXusQLOG4tRv8S8fi0wVEaZ4f2avASUavu146NaVqWhS13I
6JrC/ITGiuUryxPa+9cuCovoO6w+VFzfwlhqFRTodGv147IX9md6qMoTO0n+
nPkdqOxqp6e7Xwaolpl4LaPMGKXb8H4FRYJSTr9uAkMUI+C8IUaMxSQG3q9g
M8TQ9usmWxGRxuFvxaNX9nOXlWa/DOvus6tqzbucUsv4sCqj2b5zX18ZG7tJ
7XdZr9/gvO3L2/kO2F0Z7bj3CxdQGbFHwHkDubirDXj92sYoleL9mjIUlHL6
NYFVy6p8vDMy/LJVPytjfY+KPi7VST+410YnmmafCvHMsnYxPpIZ4JBz41mV
+/vFrQ7vfnPN5lXRNVBpP6Gl7n51QLX8iVdLKaO0GO9XsCco1fbrbkdgqFME
nDc6IsZCEoPXryeI8bFfdzuyFRFpHP4K95T4bL00N/aEVG1mmH23vvW+xLz2
57ITDj3NdZYdqCoOqM6pqTPPb9V/QnTISFsX+687g8qaHAHnDeSIr27P61cx
o1TB69dbUMrpVwCrllXp5mHeM+fk2sEejfGSp35l0rihZfl1qsotzmsUrbuF
qeQREu/hHdfd9g+ov3r17cB5k4oMQKVM2kZ3vzqhWu7j1VLBKG3A+xXSB5Ry
+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
AA==

--0-703175191-1644974237=:18794--
